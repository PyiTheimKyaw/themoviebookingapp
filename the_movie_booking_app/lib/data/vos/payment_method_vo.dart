import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';
part 'payment_method_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PAYMENT_VO,adapterName: 'PaymentVOAdapter')
class PaymentMethodVO{
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;
  @JsonKey(name: 'name')
  @HiveField(1)
  String? name;
  @JsonKey(name: 'description')
  @HiveField(2)
  String? description;
  @HiveField(3)
  bool? isSelected;

  PaymentMethodVO(this.id, this.name, this.description, this.isSelected);
  factory PaymentMethodVO.fromJson(Map<String,dynamic> json) => _$PaymentMethodVOFromJson(json);
  Map<String,dynamic> toJson() => _$PaymentMethodVOToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethodVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ description.hashCode ^ isSelected.hashCode;
}