// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsModel _$MovieDetailsModelFromJson(Map<String, dynamic> json) =>
    MovieDetailsModel(
      title: json['Title'] as String,
      year: json['Year'] as String,
      rated: json['Rated'] as String,
      released: json['Released'] as String,
      runtime: json['Runtime'] as String,
      genre: json['Genre'] as String,
      director: json['Director'] as String,
      writer: json['Writer'] as String,
      actors: json['Actors'] as String,
      plot: json['Plot'] as String,
      language: json['Language'] as String,
      country: json['Country'] as String,
      awards: json['Awards'] as String,
      poster: json['Poster'] as String,
      ratings: (json['Ratings'] as List<dynamic>)
          .map((e) => MovieRattingModel.fromJson(e))
          .toList(),
      metaScore: json['MetaScore'] as String,
      imdbRating: json['ImdbRating'] as String,
      imdbVotes: json['ImdbVotes'] as String,
      imdbID: json['ImdbID'] as String,
      type: json['Type'] as String,
      dvd: json['DVD'] as String,
      boxOffice: json['BoxOffice'] as String,
      production: json['Production'] as String,
      website: json['Website'] as String,
      response: json['Response'] as String,
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
      'MetaScore': instance.metaScore,
      'ImdbRating': instance.imdbRating,
      'ImdbVotes': instance.imdbVotes,
      'ImdbID': instance.imdbID,
      'Type': instance.type,
      'DVD': instance.dvd,
      'BoxOffice': instance.boxOffice,
      'Production': instance.production,
      'Website': instance.website,
      'Response': instance.response,
    };
