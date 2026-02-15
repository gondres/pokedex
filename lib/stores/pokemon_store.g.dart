// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonStore on _PokemonStoreBase, Store {
  late final _$responseAtom = Atom(name: '_PokemonStoreBase.response', context: context);

  @override
  RepositoriesResponse<List<Pokemon>> get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(RepositoriesResponse<List<Pokemon>> value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  late final _$fetchPokemonsAsyncAction = AsyncAction('_PokemonStoreBase.fetchPokemons', context: context);

  @override
  Future<void> fetchPokemons() {
    return _$fetchPokemonsAsyncAction.run(() => super.fetchPokemons());
  }

  @override
  String toString() {
    return '''
response: ${response}
    ''';
  }
}
