import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/network/responses/user_response.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

part 'user_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_USER_VO,adapterName: 'UserVOAdapter')
class UserVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;
  @JsonKey(name: 'name')
  @HiveField(1)
  String? name;
  @JsonKey(name: 'email')
  @HiveField(2)
  String? email;
  @JsonKey(name: 'phone')
  @HiveField(3)
  dynamic? phone;
  @JsonKey(name: 'total_expense')
  @HiveField(4)
  double? totalExpense;
  @JsonKey(name: 'profile_image')
  @HiveField(5)
  String? profileImage;
  @JsonKey(name: 'cards')
  @HiveField(6)
  List<CardVO>? cards;

  @HiveField(7)
  String? token;

  UserVO(
    this.id,
    this.name,
    this.email,
    this.phone,
    this.totalExpense,
    this.profileImage,
    this.cards,
    this.token,
  );

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);

  @override
  String toString() {
    return 'UserVO{id: $id, name: $name, email: $email, phone: $phone, totalExpense: $totalExpense, profileImage: $profileImage, card: $cards, token: $token}';
  }
  String? Authorization() {
    return 'Bearer $token';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          phone == other.phone &&
          totalExpense == other.totalExpense &&
          profileImage == other.profileImage &&
          cards == other.cards &&
          token == other.token;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      totalExpense.hashCode ^
      profileImage.hashCode ^
      cards.hashCode ^
      token.hashCode;
}
