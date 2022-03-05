import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/profile_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
part 'get_profile_response.g.dart';
@JsonSerializable()
class GetProfileResponse{
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  ProfileVO? data;

  GetProfileResponse(this.code, this.message, this.data);

  factory GetProfileResponse.fromJson(Map<String,dynamic> json) => _$GetProfileResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetProfileResponseToJson(this);
}