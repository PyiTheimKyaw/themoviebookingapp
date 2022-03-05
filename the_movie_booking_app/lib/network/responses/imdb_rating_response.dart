import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
part 'imdb_rating_response.g.dart';
@JsonSerializable()
class ImdbRatingResponse{
  @JsonKey(name: 'movie_results')
  List<MovieVO>? movieResults;
  @JsonKey(name: 'person_results')
  List<dynamic>? personResults;
  @JsonKey(name: 'tv_results')
  List<dynamic>? tvResults;
  @JsonKey(name: 'tv_episode_results')
  List<dynamic>? tvEpisodeResults;
  @JsonKey(name: 'tv_season_results')
  List<dynamic>? tvSeasonResults;


  ImdbRatingResponse(this.movieResults, this.personResults, this.tvResults,
      this.tvEpisodeResults, this.tvSeasonResults);

  factory ImdbRatingResponse.fromJson(Map<String,dynamic> json) => _$ImdbRatingResponseFromJson(json);
  Map<String,dynamic> toJson() => _$ImdbRatingResponseToJson(this);
}