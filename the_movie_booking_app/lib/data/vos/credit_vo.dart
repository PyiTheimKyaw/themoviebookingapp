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
  @JsonKey(name: 'department')
  @HiveField(12)
  String? department;
  @JsonKey(name: 'job')
  @HiveField(13)
  String? job;

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
      this.order,
      this.department,
      this.job);

  factory CreditVO.fromJson(Map<String, dynamic> json) =>
      _$CreditVOFromJson(json);

  Map<String, dynamic> toJson() => _$CreditVOToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditVO &&
          runtimeType == other.runtimeType &&
          adult == other.adult &&
          gender == other.gender &&
          id == other.id &&
          knownForDepartment == other.knownForDepartment &&
          name == other.name &&
          originalName == other.originalName &&
          popularity == other.popularity &&
          profilePath == other.profilePath &&
          castId == other.castId &&
          character == other.character &&
          creditId == other.creditId &&
          order == other.order &&
          department == other.department &&
          job == other.job;

  @override
  int get hashCode =>
      adult.hashCode ^
      gender.hashCode ^
      id.hashCode ^
      knownForDepartment.hashCode ^
      name.hashCode ^
      originalName.hashCode ^
      popularity.hashCode ^
      profilePath.hashCode ^
      castId.hashCode ^
      character.hashCode ^
      creditId.hashCode ^
      order.hashCode ^
      department.hashCode ^
      job.hashCode;
}
