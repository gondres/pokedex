class Ability {
  final String name;
  final bool isHidden;

  Ability({required this.name, required this.isHidden});

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(name: json['ability']['name'] ?? '', isHidden: json['is_hidden'] ?? false);
  }
}

class Stat {
  final String name;
  final int baseStat;

  Stat({required this.name, required this.baseStat});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(name: json['stat']['name'] ?? '', baseStat: json['base_stat'] ?? 0);
  }
}

class Move {
  final String name;
  final int? levelLearnedAt;
  final String learnMethod;

  Move({required this.name, this.levelLearnedAt, this.learnMethod = 'level-up'});

  factory Move.fromJson(Map<String, dynamic> json) {
    final move = json['move'] as Map<String, dynamic>?;
    final name = move?['name'] as String? ?? '';
    final details = json['version_group_details'] as List?;
    int? level;
    String method = 'level-up';
    if (details != null && details.isNotEmpty) {
      // Prefer level-up with lowest level for "learned at"
      for (final d in details) {
        final detail = d as Map<String, dynamic>?;
        if (detail == null) continue;
        final m = detail['move_learn_method'] as Map<String, dynamic>?;
        final methodName = m?['name'] as String? ?? '';
        final l = detail['level_learned_at'] as int?;
        if (methodName == 'level-up' && l != null) {
          if (level == null || l < level) {
            level = l;
            method = methodName;
          }
        } else if (level == null && l != null) {
          level = l;
          method = methodName;
        }
      }
      if (level == null && details.isNotEmpty) {
        final first = details[0] as Map<String, dynamic>?;
        level = first?['level_learned_at'] as int?;
        method = (first?['move_learn_method'] as Map?)?['name'] as String? ?? 'level-up';
      }
    }
    return Move(name: name, levelLearnedAt: level, learnMethod: method);
  }
}

class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final String sprite;
  final int height;
  final int weight;
  final List<Ability> abilities;
  final List<Stat> stats;
  final List<Move> moves;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.sprite,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.stats,
    this.moves = const [],
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List).map((t) => t['type']['name'] as String).toList();
    final sprite = json['sprites']['other']['official-artwork']['front_default'] ?? json['sprites']['front_default'] ?? '';
    final abilities = (json['abilities'] as List).map((a) => Ability.fromJson(a)).toList();
    final stats = (json['stats'] as List).map((s) => Stat.fromJson(s)).toList();
    final movesList = json['moves'] as List?;
    final moves = movesList != null
        ? (movesList).map((m) => Move.fromJson(m as Map<String, dynamic>)).toList()
        : <Move>[];

    return Pokemon(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      types: types,
      sprite: sprite,
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      abilities: abilities,
      stats: stats,
      moves: moves,
    );
  }
}

class SpeciesData {
  final String description;
  final String genus;
  final String? evolutionChainUrl;

  SpeciesData({required this.description, required this.genus, this.evolutionChainUrl});

  factory SpeciesData.fromJson(Map<String, dynamic> json) {
    String description = '';
    final flavorEntries = json['flavor_text_entries'] as List?;
    if (flavorEntries != null) {
      try {
        final enEntry = flavorEntries.firstWhere((entry) => entry['language']['name'] == 'en', orElse: () => null);
        if (enEntry != null) {
          description = (enEntry['flavor_text'] as String).replaceAll('\f', ' ').trim();
        }
      } catch (e) {
        description = '';
      }
    }

    String genus = '';
    final genera = json['genera'] as List?;
    if (genera != null) {
      try {
        final enGenus = genera.firstWhere((g) => g['language']['name'] == 'en', orElse: () => null);
        if (enGenus != null) {
          genus = enGenus['genus'] ?? '';
        }
      } catch (e) {
        genus = '';
      }
    }

    String? evolutionChainUrl;
    final evolutionChain = json['evolution_chain'] as Map<String, dynamic>?;
    if (evolutionChain != null) {
      evolutionChainUrl = evolutionChain['url'] as String?;
    }

    return SpeciesData(description: description, genus: genus, evolutionChainUrl: evolutionChainUrl);
  }
}

/// One step in an evolution chain (species name + optional level).
class EvolutionStep {
  final String speciesName;
  final int? minLevel;

  EvolutionStep({required this.speciesName, this.minLevel});
}

/// Flattened evolution chain for display (e.g. Bulbasaur -> Ivysaur Lv.16 -> Venusaur Lv.32).
class EvolutionChainData {
  final List<EvolutionStep> steps;

  EvolutionChainData({required this.steps});

  factory EvolutionChainData.fromJson(Map<String, dynamic> json) {
    final chain = json['chain'] as Map<String, dynamic>?;
    final steps = <EvolutionStep>[];
    void walk(Map<String, dynamic>? node) {
      if (node == null) return;
      final species = node['species'] as Map<String, dynamic>?;
      final name = species?['name'] as String? ?? '';
      if (name.isEmpty) return;
      final details = node['evolution_details'] as List?;
      int? minLevel;
      if (details != null && details.isNotEmpty) {
        final first = details[0] as Map<String, dynamic>?;
        final level = first?['min_level'];
        if (level != null) minLevel = level as int?;
      }
      steps.add(EvolutionStep(speciesName: name, minLevel: minLevel));
      final evolvesTo = node['evolves_to'] as List?;
      if (evolvesTo != null && evolvesTo.isNotEmpty) {
        walk(evolvesTo[0] as Map<String, dynamic>);
      }
    }
    walk(chain);
    return EvolutionChainData(steps: steps);
  }
}
