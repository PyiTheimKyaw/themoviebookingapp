import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
part 'get_cinema_day_timeslot_response.g.dart';
@JsonSerializable()
class GetCinemaDayTimeslotResponse{
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<CinemaDayTimeSlotVO>? data;

  GetCinemaDayTimeslotResponse(this.code, this.message, this.data);

  factory GetCinemaDayTimeslotResponse.fromJson(Map<String,dynamic> json) => _$GetCinemaDayTimeslotResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetCinemaDayTimeslotResponseToJson(this);
}