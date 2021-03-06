// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_day_time_slot_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaDayTimeslotVOAdapter extends TypeAdapter<CinemaDayTimeSlotVO> {
  @override
  final int typeId = 12;

  @override
  CinemaDayTimeSlotVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaDayTimeSlotVO(
      fields[0] as int?,
      fields[1] as String?,
      (fields[2] as List?)?.cast<TimeSlotVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, CinemaDayTimeSlotVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cinemaId)
      ..writeByte(1)
      ..write(obj.cinema)
      ..writeByte(2)
      ..write(obj.timeSlots);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaDayTimeslotVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaDayTimeSlotVO _$CinemaDayTimeSlotVOFromJson(Map<String, dynamic> json) =>
    CinemaDayTimeSlotVO(
      json['cinema_id'] as int?,
      json['cinema'] as String?,
      (json['timeslots'] as List<dynamic>?)
          ?.map((e) => TimeSlotVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CinemaDayTimeSlotVOToJson(
        CinemaDayTimeSlotVO instance) =>
    <String, dynamic>{
      'cinema_id': instance.cinemaId,
      'cinema': instance.cinema,
      'timeslots': instance.timeSlots,
    };
