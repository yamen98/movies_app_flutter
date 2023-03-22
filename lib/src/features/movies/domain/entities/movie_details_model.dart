import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/src/features/movies/domain/entities/movie_ratting_model.dart';

part 'movie_details_model.g.dart';
@JsonSerializable(fieldRename: FieldRename.pascal)
class MovieDetailsModel {
  MovieDetailsModel({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.ratings,
    required this.metaScore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbID,
    required this.type,
    required this.dvd,
    required this.boxOffice,
    required this.production,
    required this.website,
    required this.response,
  });
  late final String title;
  late final String year;
  late final String rated;
  late final String released;
  late final String runtime;
  late final String genre;
  late final String director;
  late final String writer;
  late final String actors;
  late final String plot;
  late final String language;
  late final String country;
  late final String awards;
  late final String poster;
  late final List<MovieRattingModel> ratings;
  late final String metaScore;
  late final String imdbRating;
  late final String imdbVotes;
  late final String imdbID;
  late final String type;
  late final String dvd;
  late final String boxOffice;
  late final String production;
  late final String website;
  late final String response;

  factory MovieDetailsModel.fromJson(json) => _$MovieDetailsModelFromJson(json);

  toJson() => _$MovieDetailsModelToJson(this);

  static List<MovieDetailsModel> fromJsonList(List json) {
    return json.map((e) => MovieDetailsModel.fromJson(e)).toList();
  }

}

