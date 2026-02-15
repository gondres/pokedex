// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonStore on _PokemonStoreBase, Store {
  late final _$responseAtom = Atom(
    name: '_PokemonStoreBase.response',
    context: context,
  );

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

  late final _$pokemonsAtom = Atom(
    name: '_PokemonStoreBase.pokemons',
    context: context,
  );

  @override
  ObservableList<Pokemon> get pokemons {
    _$pokemonsAtom.reportRead();
    return super.pokemons;
  }

  @override
  set pokemons(ObservableList<Pokemon> value) {
    _$pokemonsAtom.reportWrite(value, super.pokemons, () {
      super.pokemons = value;
    });
  }

  late final _$isLoadingMoreAtom = Atom(
    name: '_PokemonStoreBase.isLoadingMore',
    context: context,
  );

  @override
  bool get isLoadingMore {
    _$isLoadingMoreAtom.reportRead();
    return super.isLoadingMore;
  }

  @override
  set isLoadingMore(bool value) {
    _$isLoadingMoreAtom.reportWrite(value, super.isLoadingMore, () {
      super.isLoadingMore = value;
    });
  }

  late final _$_hasMoreAtom = Atom(
    name: '_PokemonStoreBase._hasMore',
    context: context,
  );

  @override
  bool get _hasMore {
    _$_hasMoreAtom.reportRead();
    return super._hasMore;
  }

  @override
  set _hasMore(bool value) {
    _$_hasMoreAtom.reportWrite(value, super._hasMore, () {
      super._hasMore = value;
    });
  }

  late final _$loadMoreAsyncAction = AsyncAction(
    '_PokemonStoreBase.loadMore',
    context: context,
  );

  @override
  Future<void> loadMore() {
    return _$loadMoreAsyncAction.run(() => super.loadMore());
  }

  late final _$fetchInitialAsyncAction = AsyncAction(
    '_PokemonStoreBase.fetchInitial',
    context: context,
  );

  @override
  Future<void> fetchInitial() {
    return _$fetchInitialAsyncAction.run(() => super.fetchInitial());
  }

  late final _$fetchPokemonsAsyncAction = AsyncAction(
    '_PokemonStoreBase.fetchPokemons',
    context: context,
  );

  @override
  Future<void> fetchPokemons() {
    return _$fetchPokemonsAsyncAction.run(() => super.fetchPokemons());
  }

  @override
  String toString() {
    return '''
response: ${response},
pokemons: ${pokemons},
isLoadingMore: ${isLoadingMore}
    ''';
  }
}
