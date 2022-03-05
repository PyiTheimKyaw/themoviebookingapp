// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imdb_rating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImdbRatingResponse _$ImdbRatingResponseFromJson(Map<String, dynamic> json) =>
    ImdbRatingResponse(
      (json['movie_results'] as List<dynamic>?)
          ?.map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['person_results'] as List<dynamic>?,
      json['tv_results'] as List<dynamic>?,
      json['tv_episode_results'] as List<dynamic>?,
      json['tv_season_results'] as List<dynamic>?,
    );

Map<String, dynamic> _$ImdbRatingResponseToJson(ImdbRatingResponse instance) =>
    <String, dynamic>{
      'movie_results': instance.movieResults,
      'person_results': instance.personResults,
      'tv_results': instance.tvResults,
      'tv_episode_results': instance.tvEpisodeResults,
      'tv_season_results': instance.tvSeasonResults,
    };
