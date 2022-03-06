import 'package:json_annotation/json_annotation.dart';

import 'card_vo.dart';
part 'profile_vo.g.dart';
@JsonSerializable()
class ProfileVO{
  @JsonKey(name: 'id')
  // @HiveField(0)
  int? id;
  @JsonKey(name: 'name')
  // @HiveField(1)
  String? name;
  @JsonKey(name: 'email')
  // @HiveField(2)
  String? email;
  @JsonKey(name: 'phone')
  // @HiveField(3)
  dynamic? phone;
  @JsonKey(name: 'total_expense')
  // @HiveField(4)
  double? totalExpense;
  @JsonKey(name: 'profile_image')
  // @HiveField(5)
  String? profileImage;
  @JsonKey(name: 'card')
  // @HiveField(6)
  List<CardVO>? card;

  ProfileVO(this.id, this.name, this.email, this.phone, this.totalExpense,
      this.profileImage, this.card);

  factory ProfileVO.fromJson(Map<String, dynamic> json) => _$ProfileVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileVOToJson(this);
}