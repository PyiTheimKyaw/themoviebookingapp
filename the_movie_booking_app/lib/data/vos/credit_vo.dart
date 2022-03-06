import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

part 'credit_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CREDIT_VO,adapterName: 'CreditVOAdapter')
class CreditVO {
  @JsonKey(name: 'adult')
  @HiveField(0)
  bool? adult;
  @JsonKey(name: 'gender')
  @HiveField(1)
  int? gender;
  @JsonKey(name: 'id')
  @HiveField(2)
  int? id;
  @JsonKey(name: 'known_for_department')
  @HiveField(3)
  String? knownForDepartment;
  @JsonKey(name: 'name')
  @HiveField(4)
  String? name;
  @JsonKey(name: 'original_name')
  @HiveField(5)
  String? originalName;
  @JsonKey(name: 'popularity')
  @HiveField(6)
  double? popularity;
  @JsonKey(name: 'profile_path')
  @HiveField(7)
  String? profilePath;
  @JsonKey(name: 'cast_id')
  @HiveField(8)
  int? castId;
  @JsonKey(name: 'character')
  @HiveField(9)
  String? character;
  @JsonKey(name: 'credit_id')
  @HiveField(10)
  String? creditId;
  @JsonKey(name: 'order')
  @HiveField(11)
  int? order;

  CreditVO(
      this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      this.creditId,
      this.order);

  factory CreditVO.fromJson(Map<String, dynamic> json) =>
      _$CreditVOFromJson(json);

  Map<String, dynamic> toJson() => _$CreditVOToJson(this);
}
