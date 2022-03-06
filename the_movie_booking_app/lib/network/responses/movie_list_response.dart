import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/date_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
part 'movie_list_response.g.dart';
@JsonSerializable()
class MovieListResponse{
  @JsonKey(name: 'dates')
  DateVO? dates;
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<MovieVO>? results;


  MovieListResponse(this.dates, this.results, this.page);

  factory MovieListResponse.fromJson(Map<String,dynamic> json) => _$MovieListResponseFromJson(json);
  Map<String,dynamic> toJson() => _$MovieListResponseToJson(this);

}