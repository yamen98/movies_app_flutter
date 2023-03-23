import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/src/features/movies/domain/entities/movie_ratting_model.dart';

part 'movie_details_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MovieDetailsModel {
  MovieDetailsModel(
      this.title,
      this.year,
      this.rated,
      this.released,
      this.runtime,
      this.genre,
      this.director,
      this.writer,
      this.actors,
      this.plot,
      this.language,
      this.country,
      this.awards,
      this.poster,
      this.ratings,
      this.metaScore,
      this.imdbRating,
      this.imdbVotes,
      this.imdbID,
      this.type,
      this.dvd,
      this.boxOffice,
      this.production,
      this.website,
      this.response);

  final String? title;
  final String? year;
  final String? rated;
  final String? released;
  final String? runtime;
  final String? genre;
  final String? director;
  final String? writer;
  final String? actors;
  final String? plot;
  final String? language;
  final String? country;
  final String? awards;
  final String? poster;
  final List<MovieRattingModel> ratings;

  @JsonKey(name: "Metascore")
  final String? metaScore;

  @JsonKey(name: "imdbRating")
  final String? imdbRating;

  @JsonKey(name: "imdbVotes")
  final String? imdbVotes;

  @JsonKey(name: "imdbID")
  final String imdbID;
  final String type;
  final String? dvd;
  final String? boxOffice;
  final String? production;
  final String? website;
  final String? response;

  factory MovieDetailsModel.fromJson(json) => _$MovieDetailsModelFromJson(json);

  toJson() => _$MovieDetailsModelToJson(this);

  static List<MovieDetailsModel> fromJsonList(List json) {
    return json.map((e) => MovieDetailsModel.fromJson(e)).toList();
  }
}
