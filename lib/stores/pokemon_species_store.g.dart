// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_species_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonSpeciesStore on _PokemonSpeciesStoreBase, Store {
  late final _$responseAtom = Atom(name: '_PokemonSpeciesStoreBase.response', context: context);
  late final _$evolutionChainResponseAtom = Atom(name: '_PokemonSpeciesStoreBase.evolutionChainResponse', context: context);

  @override
  RepositoriesResponse<SpeciesData> get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(RepositoriesResponse<SpeciesData> value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  @override
  RepositoriesResponse<EvolutionChainData> get evolutionChainResponse {
    _$evolutionChainResponseAtom.reportRead();
    return super.evolutionChainResponse;
  }

  @override
  set evolutionChainResponse(RepositoriesResponse<EvolutionChainData> value) {
    _$evolutionChainResponseAtom.reportWrite(value, super.evolutionChainResponse, () {
      super.evolutionChainResponse = value;
    });
  }

  late final _$fetchSpeciesAsyncAction = AsyncAction('_PokemonSpeciesStoreBase.fetchSpecies', context: context);

  @override
  Future<void> fetchSpecies(int pokemonId) {
    return _$fetchSpeciesAsyncAction.run(() => super.fetchSpecies(pokemonId));
  }

  @override
  String toString() {
    return '''
response: ${response}
    ''';
  }
}
