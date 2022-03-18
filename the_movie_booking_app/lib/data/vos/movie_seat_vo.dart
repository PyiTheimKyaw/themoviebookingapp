
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
part 'movie_seat_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_SEAT_VO,adapterName: 'MovieSeatVOAdapter')
class MovieSeatVO{
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;
  @JsonKey(name: 'type')
  @HiveField(1)
  String? type;
  @JsonKey(name: 'seat_name')
  @HiveField(2)
  String? seatName;
  @JsonKey(name: 'symbol')
  @HiveField(3)
  String? symbol;
  @JsonKey(name: 'price')
  @HiveField(4)
  double? price;
  @HiveField(5)
  bool? isSelected;

  factory MovieSeatVO.fromJson(Map<String,dynamic> json) => _$MovieSeatVOFromJson(json);
  Map<String,dynamic> toJson() => _$MovieSeatVOToJson(this);
  MovieSeatVO(this.id, this.type, this.seatName, this.symbol, this.price,this.isSelected);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieSeatVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          seatName == other.seatName &&
          symbol == other.symbol &&
          price == other.price &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      seatName.hashCode ^
      symbol.hashCode ^
      price.hashCode ^
      isSelected.hashCode;
}