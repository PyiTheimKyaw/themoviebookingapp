import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';
part 'cinema_day_time_slot_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_DAY_TIMESLOT_VO,adapterName: 'CinemaDayTimeslotVOAdapter')
class CinemaDayTimeSlotVO{

    @JsonKey(name: 'cinema_id')
    @HiveField(0)
    int? cinemaId;
    @JsonKey(name: 'cinema')
    @HiveField(1)
    String? cinema;
    @JsonKey(name: 'timeslots')
    @HiveField(2)
    List<TimeSlotVO>? timeSlots;

    CinemaDayTimeSlotVO(this.cinemaId, this.cinema, this.timeSlots);

    factory CinemaDayTimeSlotVO.fromJson(Map<String,dynamic> json) => _$CinemaDayTimeSlotVOFromJson(json);
    Map<String,dynamic> toJson() => _$CinemaDayTimeSlotVOToJson(this);

    @override
  String toString() {
    return 'CinemaDayTimeSlotVO{cinemaId: $cinemaId, cinema: $cinema, timeSlots: $timeSlots}';
  }
}
