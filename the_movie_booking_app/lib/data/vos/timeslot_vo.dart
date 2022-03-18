import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

part 'timeslot_vo.g.dart';
@HiveType(typeId: HIVE_TYPE_ID_TIMESLOT_VO,adapterName: 'TimeslotVOAdapter')
@JsonSerializable()
class TimeSlotVO {
  @JsonKey(name: 'cinema_day_timeslot_id')
  @HiveField(0)
  int? cinemaDayTimeSlotId;
  @JsonKey(name: 'start_time')
  @HiveField(1)
  String? startTime;

  @HiveField(2)
  bool? isSelected;

  TimeSlotVO(this.cinemaDayTimeSlotId, this.startTime, this.isSelected);

  factory TimeSlotVO.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotVOFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotVOToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlotVO &&
          runtimeType == other.runtimeType &&
          cinemaDayTimeSlotId == other.cinemaDayTimeSlotId &&
          startTime == other.startTime &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      cinemaDayTimeSlotId.hashCode ^ startTime.hashCode ^ isSelected.hashCode;
}
