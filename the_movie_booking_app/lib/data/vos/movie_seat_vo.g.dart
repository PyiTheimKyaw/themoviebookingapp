// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_seat_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieSeatVOAdapter extends TypeAdapter<MovieSeatVO> {
  @override
  final int typeId = 14;

  @override
  MovieSeatVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieSeatVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as double?,
      fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieSeatVO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.seatName)
      ..writeByte(3)
      ..write(obj.symbol)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieSeatVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSeatVO _$MovieSeatVOFromJson(Map<String, dynamic> json) => MovieSeatVO(
      json['id'] as int?,
      json['type'] as String?,
      json['seat_name'] as String?,
      json['symbol'] as String?,
      (json['price'] as num?)?.toDouble(),
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$MovieSeatVOToJson(MovieSeatVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
      'isSelected': instance.isSelected,
    };
