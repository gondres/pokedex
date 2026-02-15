import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex_app/constant/app_assets.dart';
import 'package:pokedex_app/constant/app_size.dart';
import 'package:pokedex_app/model/pokemon_model.dart';
import 'package:pokedex_app/ui/widgets/pokemon_loader.dart';
import 'package:pokedex_app/ui/widgets/skeleton_card.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pokedex_app/model/repositories_response.dart';
import 'package:pokedex_app/repository/pokemon_repository.dart';
import 'package:pokedex_app/ui/detail_pokemon_page.dart';
import 'package:pokedex_app/ui/widgets/home_pokemon_hero.dart';
import 'package:pokedex_app/ui/widgets/pokemon_card.dart';
import 'package:pokedex_app/ui/widgets/pokemon_detail_panel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/pokemon_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokemonStore store = PokemonStore(PokemonRepository());
  Pokemon? selected;

  @override
  void initState() {
    super.initState();
    store.fetchPokemons(); // load data on start
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final crossAxisCount = isLandscape ? 1 : 2;

    return Scaffold(
      body: Observer(
        builder: (_) {
          switch (store.response.status) {
            case ResponseStatus.loading:
              return _buildSkeletonList(crossAxisCount, isLandscape);
            case ResponseStatus.success:
              final pokemons = store.response.data ?? []; // List<Pokemon>
              return isLandscape
                  ? Row(
                      children: [
                        selected != null
                            ? Expanded(
                                flex: 1,
                                child: HomePokemonHero(selected: selected!, onBack: () => setState(() => selected = null)),
                              )
                            : Expanded(flex: 1, child: _buildList(pokemons, crossAxisCount, isLandscape)),
                        Expanded(
                          flex: 2,
                          child: selected != null
                              ? PokemonDetailPanel(key: ValueKey(selected!.id), pokemon: selected!)
                              : SafeArea(
                                  child: Container(
                                    child: Center(
                                      child: Column(
                                        spacing: 20,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          PokemonLoader(pulseColor: Colors.red),
                                          Text('Choose Pokecard'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    )
                  : _buildList(pokemons, crossAxisCount, isLandscape);
            case ResponseStatus.error:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error: ${store.response.errorMessage}'),
                    const SizedBox(height: 8),
                    ElevatedButton(onPressed: () => store.fetchPokemons(), child: const Text('Retry')),
                  ],
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget _buildSkeletonList(int crossAxisCount, bool isLandscape) {
    const skeletonItemCount = limitPage;
    return SafeArea(
      left: false,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: isLandscape ? 2 : 1.5,
          ),
          itemCount: skeletonItemCount,
          itemBuilder: (_, index) => SkeletonCard(isLandscape: isLandscape),
        ),
      ),
    );
  }

  Widget _buildList(List pokemons, int crossAxisCount, bool isLandscape) {
    return SafeArea(
      left: false,
      child: GridView.builder(
        padding: const EdgeInsets.all(8),

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,

          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: isLandscape ? 2 : 1.5,
        ),
        itemCount: pokemons.length,
        itemBuilder: (_, index) {
          final pokemon = pokemons[index];
          return isLandscape
              ? PokemonCardLandscape(pokemon: pokemon, onTap: () => setState(() => selected = pokemon))
              : PokemonCard(
                  pokemon: pokemon,
                  onTap: () {
                    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
                    if (isLandscape) {
                      setState(() => selected = pokemon);
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPokemonPage(pokemon: pokemon)));
                    }
                  },
                );
        },
      ),
    );
  }
}
