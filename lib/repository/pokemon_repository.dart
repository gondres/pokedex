import 'package:dio/dio.dart';
import 'package:pokedex_app/model/pokemon_model.dart';
import 'package:pokedex_app/model/repositories_response.dart';

const limitPage = 6;

class PokemonRepository {
  final Dio _dio = Dio();

  Future<RepositoriesResponse<List<Pokemon>>> fetchPokemons({required int limit, required int offset}) async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset');

      final results = response.data['results'] as List;

      final pokemons = await Future.wait(
        results.map((pokemon) async {
          final detailsRes = await _dio.get(pokemon['url']);
          return Pokemon.fromJson(detailsRes.data);
        }),
      );

      return RepositoriesResponse.success(pokemons);
    } catch (e) {
      return RepositoriesResponse.error(e.toString());
    }
  }

  /// Fetches species data (description, genus, evolution_chain url) for a Pokémon by id.
  Future<RepositoriesResponse<SpeciesData>> fetchPokemonSpecies(int pokemonId) async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon-species/$pokemonId');
      final species = SpeciesData.fromJson(response.data as Map<String, dynamic>);
      return RepositoriesResponse.success(species);
    } catch (e) {
      return RepositoriesResponse.error('Failed to load species: $e');
    }
  }

  /// Fetches evolution chain from PokeAPI (e.g. https://pokeapi.co/api/v2/evolution-chain/1/).
  Future<RepositoriesResponse<EvolutionChainData>> fetchEvolutionChain(String url) async {
    try {
      final response = await _dio.get(url);
      final chain = EvolutionChainData.fromJson(response.data as Map<String, dynamic>);
      return RepositoriesResponse.success(chain);
    } catch (e) {
      return RepositoriesResponse.error('Failed to load evolution: $e');
    }
  }
}
