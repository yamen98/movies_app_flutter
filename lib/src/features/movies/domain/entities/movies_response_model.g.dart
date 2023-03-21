// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesResponseModel _$MoviesResponseModelFromJson(Map<String, dynamic> json) =>
    MoviesResponseModel(
      search: (json['Search'] as List<dynamic>)
          .map((e) => MoviesModel.fromJson(e))
          .toList(),
      totalResults: json['totalResults'] as String,
      response: json['Response'] as String,
    );

Map<String, dynamic> _$MoviesResponseModelToJson(
        MoviesResponseModel instance) =>
    <String, dynamic>{
      'Search': instance.search,
      'totalResults': instance.totalResults,
      'Response': instance.response,
    };
