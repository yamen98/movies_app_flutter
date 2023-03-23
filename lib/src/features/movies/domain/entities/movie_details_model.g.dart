// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsModel _$MovieDetailsModelFromJson(Map<String, dynamic> json) =>
    MovieDetailsModel(
      json['Title'] as String?,
      json['Year'] as String?,
      json['Rated'] as String?,
      json['Released'] as String?,
      json['Runtime'] as String?,
      json['Genre'] as String?,
      json['Director'] as String?,
      json['Writer'] as String?,
      json['Actors'] as String?,
      json['Plot'] as String?,
      json['Language'] as String?,
      json['Country'] as String?,
      json['Awards'] as String?,
      json['Poster'] as String?,
      (json['Ratings'] as List<dynamic>)
          .map((e) => MovieRattingModel.fromJson(e))
          .toList(),
      json['Metascore'] as String?,
      json['imdbRating'] as String?,
      json['imdbVotes'] as String?,
      json['imdbID'] as String,
      json['Type'] as String,
      json['Dvd'] as String?,
      json['BoxOffice'] as String?,
      json['Production'] as String?,
      json['Website'] as String?,
      json['Response'] as String?,
    );

Map<String, dynamic> _$MovieDetailsModelToJson(MovieDetailsModel instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'Rated': instance.rated,
      'Released': instance.released,
      'Runtime': instance.runtime,
      'Genre': instance.genre,
      'Director': instance.director,
      'Writer': instance.writer,
      'Actors': instance.actors,
      'Plot': instance.plot,
      'Language': instance.language,
      'Country': instance.country,
      'Awards': instance.awards,
      'Poster': instance.poster,
      'Ratings': instance.ratings,
      'Metascore': instance.metaScore,
      'imdbRating': instance.imdbRating,
      'imdbVotes': instance.imdbVotes,
      'imdbID': instance.imdbID,
      'Type': instance.type,
      'Dvd': instance.dvd,
      'BoxOffice': instance.boxOffice,
      'Production': instance.production,
      'Website': instance.website,
      'Response': instance.response,
    };
