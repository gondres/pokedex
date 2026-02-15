import 'package:mobx/mobx.dart';
import 'package:pokedex_app/model/pokemon_model.dart';
import 'package:pokedex_app/model/repositories_response.dart';
import 'package:pokedex_app/repository/pokemon_repository.dart';

part 'pokemon_species_store.g.dart';

class PokemonSpeciesStore = _PokemonSpeciesStoreBase with _$PokemonSpeciesStore;

abstract class _PokemonSpeciesStoreBase with Store {
  final PokemonRepository repository;

  _PokemonSpeciesStoreBase(this.repository);

  @observable
  RepositoriesResponse<SpeciesData> response = RepositoriesResponse.initial();

  @observable
  RepositoriesResponse<EvolutionChainData> evolutionChainResponse = RepositoriesResponse.initial();

  @action
  Future<void> fetchSpecies(int pokemonId) async {
    response = RepositoriesResponse.loading();
    evolutionChainResponse = RepositoriesResponse.initial();

    try {
      final repoResponse = await repository.fetchPokemonSpecies(pokemonId);
      response = repoResponse;

      if (repoResponse.status == ResponseStatus.success && repoResponse.data?.evolutionChainUrl != null) {
        final chainResponse = await repository.fetchEvolutionChain(repoResponse.data!.evolutionChainUrl!);
        evolutionChainResponse = chainResponse;
      }
    } catch (e) {
      response = RepositoriesResponse.error(e.toString());
    }
  }
}
