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
import 'package:pokedex_app/ui/widgets/home_pokemon_hero.dart';
import 'package:pokedex_app/ui/widgets/pokemon_detail_panel.dart';
import 'package:pokedex_app/ui/widgets/pokemon_loader.dart';

class DetailPokemonPage extends StatefulWidget {
  const DetailPokemonPage({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  State<DetailPokemonPage> createState() => _DetailPokemonPageState();
}

class _DetailPokemonPageState extends State<DetailPokemonPage> {
  late final PokemonSpeciesStore _speciesStore;

  @override
  void initState() {
    super.initState();
    _speciesStore = PokemonSpeciesStore(PokemonRepository());
    _speciesStore.fetchSpecies(widget.pokemon.id);
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      // appBar: AppBar(title: Text(widget.pokemon.name[0].toUpperCase() + widget.pokemon.name.substring(1))),
      body: Observer(
        builder: (_) {
          switch (_speciesStore.response.status) {
            case ResponseStatus.initial:
            case ResponseStatus.loading:
              return const Center(child: PokemonLoader(pulseColor: Colors.red));
            case ResponseStatus.success:
              final species = _speciesStore.response.data;
              final primaryType = widget.pokemon.types.isNotEmpty ? widget.pokemon.types[0] : 'normal';
              final gradientColors = AppColors.typeGradients[primaryType] ?? AppColors.typeGradients['normal']!;

              return isLandscape
                  ? Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: HomePokemonHero(selected: widget.pokemon!, onBack: () => Navigator.pop(context)),
                        ),

                        Expanded(
                          flex: 2,
                          child: PokemonDetailPanel(key: ValueKey(widget.pokemon.id), pokemon: widget.pokemon),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(24),
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
                                          GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Row(
                                              children: [
                                                Icon(Icons.arrow_back_ios_new_sharp, size: 14, color: Colors.white70),
                                                Text('Back to list', style: TextStyle(color: Colors.white)),
                                              ],
                                            ),
                                          ),
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
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(type.capitalize(), style: const TextStyle(color: Colors.white, fontSize: 14)),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "#${widget.pokemon.id.toString().padLeft(3, '0')}",
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
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                            ),
                            height: MediaQuery.of(context).size.height / 1.6,
                            child: DefaultTabController(
                              length: 4,
                              child: Column(
                                children: [
                                  SizedBox(height: 24),
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
                        Positioned(
                          top: -150,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.white.withOpacity(0.2),
                              border: Border.all(color: AppColors.typeColors[widget.pokemon.types[0]]!, width: 1),
                            ),
                          ),
                        ),
                        Positioned(
                          // top: 0,
                          right: -110,
                          // left: 200,
                          top: 60,
                          child: Opacity(
                            opacity: 0.1,
                            child: Image.asset(
                              AppAssets.background,
                              color: Colors.white,
                              height: 400,
                              width: 400,
                              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                            ),
                          ),
                        ),

                        Positioned(
                          right: 0,
                          left: 0,
                          top: MediaQuery.of(context).size.height / 5,
                          child: Center(
                            child: Center(
                              child: Image.network(
                                widget.pokemon.sprite,
                                height: 180,
                                width: 180,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
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
      ),
    );
  }
}
