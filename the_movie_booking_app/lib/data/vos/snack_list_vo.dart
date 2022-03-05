import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';
part 'snack_list_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SNACK_LIST_VO,adapterName: 'SnackListVOAdapter')
class SnackListVO{
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;
  @JsonKey(name: 'name')
  @HiveField(1)
  String? name;
  @JsonKey(name: 'description')
  @HiveField(2)
  String? description;
  @JsonKey(name: 'price')
  @HiveField(3)
  double? price;
  @JsonKey(name: 'image')
  @HiveField(4)
  String? image;
  @JsonKey(name: 'unit_price')
  @HiveField(5)
  int? unitPrice;
  @JsonKey(name: 'total_price')
  @HiveField(6)
  int? totalPrice;
  @JsonKey(name: 'quantity')
  @HiveField(7)
  int? quantity;


  SnackListVO(this.id, this.name, this.description, this.price, this.image,
      this.unitPrice, this.totalPrice, this.quantity);

  factory SnackListVO.fromJson(Map<String, dynamic> json) =>
      _$SnackListVOFromJson(json);

  Map<String, dynamic> toJson() => _$SnackListVOToJson(this);
}