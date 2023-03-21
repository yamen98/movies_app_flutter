import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_model.dart';

part 'movies_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MoviesResponseModel {
  @JsonKey(name: "Search")
  final List<MoviesModel> search;

  @JsonKey(name: "totalResults")
  final String totalResults;

  @JsonKey(name: "Response")
  final String response;

  MoviesResponseModel(
      {required this.search,
      required this.totalResults,
      required this.response});

  factory MoviesResponseModel.fromJson(json) =>
      _$MoviesResponseModelFromJson(json);

  toJson() => _$MoviesResponseModelToJson(this);

  static List<MoviesResponseModel> fromJsonList(List json) {
    return json.map((e) => MoviesResponseModel.fromJson(e)).toList();
  }
}
