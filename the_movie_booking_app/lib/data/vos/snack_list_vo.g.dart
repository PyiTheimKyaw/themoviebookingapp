// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack_list_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SnackListVOAdapter extends TypeAdapter<SnackListVO> {
  @override
  final int typeId = 11;

  @override
  SnackListVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SnackListVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as double?,
      fields[4] as String?,
      unitPrice: fields[5] as int?,
      totalPrice: fields[6] as int?,
      quantity: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SnackListVO obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.unitPrice)
      ..writeByte(6)
      ..write(obj.totalPrice)
      ..writeByte(7)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackListVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnackListVO _$SnackListVOFromJson(Map<String, dynamic> json) => SnackListVO(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      (json['price'] as num?)?.toDouble(),
      json['image'] as String?,
      unitPrice: json['unit_price'] as int?,
      totalPrice: json['total_price'] as int?,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$SnackListVOToJson(SnackListVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
      'unit_price': instance.unitPrice,
      'total_price': instance.totalPrice,
      'quantity': instance.quantity,
    };
