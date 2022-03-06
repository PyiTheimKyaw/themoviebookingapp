import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
part 'get_credits_by_movie_response.g.dart';
@JsonSerializable()
class GetCreditsByMovieResponse{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'cast')
  List<CreditVO>? cast;
  // @JsonKey(name: 'crew')
  // List<CreditVO>? crew;

  GetCreditsByMovieResponse(this.id, this.cast,);
  factory GetCreditsByMovieResponse.fromJson(Map<String,dynamic> json) => _$GetCreditsByMovieResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetCreditsByMovieResponseToJson(this);
}