import 'package:json_annotation/json_annotation.dart';
part 'logout_vo.g.dart';
@JsonSerializable()
class LogOutVO{
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'message')
  String? message;

  LogOutVO(this.code, this.message);

  factory LogOutVO.fromJson(Map<String, dynamic> json) =>
      _$LogOutVOFromJson(json);

  Map<String, dynamic> toJson() => _$LogOutVOToJson(this);
}