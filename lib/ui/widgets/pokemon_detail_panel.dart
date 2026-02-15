import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_app/constant/app_assets.dart';
import 'package:pokedex_app/constant/app_colors.dart';
import 'package:pokedex_app/ext/string_ext.dart';
import 'package:pokedex_app/model/pokemon_model.dart';
import 'package:pokedex_app/model/repositories_response.dart';
import 'package:pokedex_app/repository/pokemon_repository.dart';
import 'package:pokedex_app/stores/pokemon_species_store.dart';
import 'package:pokedex_app/ui/widgets/detail/about_tab.dart';
import 'package:pokedex_app/ui/widgets/detail/base_stats_tab.dart';
import 'package:pokedex_app/ui/widgets/detail/evolution_tab.dart';
import 'package:pokedex_app/ui/widgets/detail/moves_tab.dart';
import 'package:pokedex_app/ui/widgets/pokemon_loader.dart';

/// Reusable detail panel with gradient header, sprite, and tabs (About, Base Stats, Evolution, Moves).
/// Use in [DetailPokemonPage] or in [HomePage] when a Pokémon is selected in landscape.
class PokemonDetailPanel extends StatefulWidget {
  const PokemonDetailPanel({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  State<PokemonDetailPanel> createState() => _PokemonDetailPanelState();
}

class _PokemonDetailPanelState extends State<PokemonDetailPanel> {
  late final PokemonSpeciesStore _speciesStore;

  @override
  void initState() {
    super.initState();
    _speciesStore = PokemonSpeciesStore(PokemonRepository());
    _speciesStore.fetchSpecies(widget.pokemon.id);
  }

  @override
  void didUpdateWidget(covariant PokemonDetailPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pokemon.id != widget.pokemon.id) {
      _speciesStore.fetchSpecies(widget.pokemon.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final panelHeight = constraints.maxHeight;
        return Observer(
          builder: (_) {
            switch (_speciesStore.response.status) {
              case ResponseStatus.initial:
              case ResponseStatus.loading:
                return const Center(child: PokemonLoader(pulseColor: Colors.red));
              case ResponseStatus.success:
                final species = _speciesStore.response.data;
                final primaryType = widget.pokemon.types.isNotEmpty ? widget.pokemon.types[0] : 'normal';
                final gradientColors = AppColors.typeGradients[primaryType] ?? AppColors.typeGradients['normal']!;

                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: panelHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.pokemon.name.capitalize(),
                                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      Wrap(
                                        direction: Axis.horizontal,
                                        spacing: 4,
                                        children: widget.pokemon.types.map((type) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                                            child: Text(type.capitalize(), style: const TextStyle(color: Colors.white, fontSize: 14)),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '#${widget.pokemon.id.toString().padLeft(3, '0')}',
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                        ),
                        height: panelHeight / 1,
                        child: DefaultTabController(
                          length: 4,
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              TabBar(
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: Colors.blue,
                                tabs: const [
                                  Tab(text: 'About'),
                                  Tab(text: 'Base Stats'),
                                  Tab(text: 'Evolution'),
                                  Tab(text: 'Moves'),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    AboutTab(pokemon: widget.pokemon, species: species),
                                    BaseStatsTab(pokemon: widget.pokemon),
                                    EvolutionTab(evolutionResponse: _speciesStore.evolutionChainResponse),
                                    MovesTab(pokemon: widget.pokemon),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              case ResponseStatus.error:
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Error: ${_speciesStore.response.errorMessage}'),
                      const SizedBox(height: 16),
                      ElevatedButton(onPressed: () => _speciesStore.fetchSpecies(widget.pokemon.id), child: const Text('Retry')),
                    ],
                  ),
                );
            }
          },
        );
      },
    );
  }
}
