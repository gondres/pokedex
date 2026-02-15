import 'package:mobx/mobx.dart';
import 'package:pokedex_app/model/pokemon_model.dart';
import 'package:pokedex_app/repository/pokemon_repository.dart';
import 'package:pokedex_app/model/repositories_response.dart';

part 'pokemon_store.g.dart';

class PokemonStore = _PokemonStoreBase with _$PokemonStore;

abstract class _PokemonStoreBase with Store {
  final PokemonRepository repository;

  _PokemonStoreBase(this.repository);

  // Single observable holding data, status, and error
  @observable
  RepositoriesResponse<List<Pokemon>> response = RepositoriesResponse.initial();

  // Fetch Pokémon list
  @action
  Future<void> fetchPokemons() async {
    response = RepositoriesResponse.loading();

    try {
      final repoResponse = await repository.fetchPokemons();

      response = repoResponse;
    } catch (e) {
      response = RepositoriesResponse.error(e.toString());
    }
  }
}
