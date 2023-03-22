import 'package:json_annotation/json_annotation.dart';

part 'movies_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MoviesModel {
  final String? title;

  final String year;

  @JsonKey(name: "imdbID")
  final String imdbID;

  final String type;

  final String poster;

  MoviesModel(
      {this.title,
      required this.year,
      required this.imdbID,
      required this.type,
      required this.poster});

  factory MoviesModel.fromJson(json) => _$MoviesModelFromJson(json);

  toJson() => _$MoviesModelToJson(this);

  static List<MoviesModel> fromJsonList(List json) {
    return json.map((e) => MoviesModel.fromJson(e)).toList();
  }
}
