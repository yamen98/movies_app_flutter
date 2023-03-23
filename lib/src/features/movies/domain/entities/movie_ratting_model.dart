import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/src/features/movies/domain/entities/movie_ratting_model.dart';

part 'movie_ratting_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MovieRattingModel {
  MovieRattingModel({
    required this.source,
    required this.value,
  });

  late final String source;
  late final String value;

  factory MovieRattingModel.fromJson(json) => _$MovieRattingModelFromJson(json);

  toJson() => _$MovieRattingModelToJson(this);

  static List<MovieRattingModel> fromJsonList(List json) {
    return json.map((e) => MovieRattingModel.fromJson(e)).toList();
  }
}
