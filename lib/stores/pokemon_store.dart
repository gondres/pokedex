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

  @observable
  ObservableList<Pokemon> pokemons = ObservableList<Pokemon>();

  @observable
  bool isLoadingMore = false;

  int _offset = 0;
  final int _limit = limitPage;

  @observable
  bool _hasMore = true;
  // Fetch Pokémon list

  @action
  Future<void> loadMore() async {
    if (isLoadingMore || !_hasMore) return;

    isLoadingMore = true;

    final repoResponse = await repository.fetchPokemons(limit: _limit, offset: _offset);

    if (repoResponse.status == ResponseStatus.success) {
      final newData = repoResponse.data!;
      if (newData.isEmpty) {
        _hasMore = false;
      } else {
        pokemons.addAll(newData);
        _offset += _limit;
      }
    }

    isLoadingMore = false;
  }

  @action
  Future<void> fetchInitial() async {
    _offset = 0;
    _hasMore = true;
    pokemons.clear();

    response = RepositoriesResponse.loading();

    final repoResponse = await repository.fetchPokemons(limit: _limit, offset: _offset);

    if (repoResponse.status == ResponseStatus.success) {
      pokemons.addAll(repoResponse.data!);
      _offset += _limit;
      response = RepositoriesResponse.success(pokemons);
    } else {
      response = repoResponse;
    }
    if (pokemons.length < _limit) {
      _hasMore = false;
    }
  }

  @action
  Future<void> fetchPokemons() async {
    response = RepositoriesResponse.loading();

    try {
      final repoResponse = await repository.fetchPokemons(limit: _limit, offset: 0);

      response = repoResponse;
    } catch (e) {
      response = RepositoriesResponse.error(e.toString());
    }
  }
}
