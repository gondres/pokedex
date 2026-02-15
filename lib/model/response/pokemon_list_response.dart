import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'pokemon_list_response.g.dart';

PokemonListResponse pokemonListFromJson(String str) => PokemonListResponse.fromJson(json.decode(str));

String pokemonListToJson(PokemonListResponse data) => json.encode(data.toJson());

@JsonSerializable()
class PokemonListResponse {
  @JsonKey(name: "count")
  final int count;
  @JsonKey(name: "next")
  final String next;
  @JsonKey(name: "previous")
  final dynamic previous;
  @JsonKey(name: "results")
  final List<Result> results;

  PokemonListResponse({required this.count, required this.next, required this.previous, required this.results});

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) => _$PokemonListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListResponseToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "url")
  final String url;

  Result({required this.name, required this.url});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
