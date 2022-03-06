import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
part 'checkout_vo.g.dart';
@JsonSerializable()
class CheckoutVO{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'booking_no')
  String? bookingNo;
  @JsonKey(name: 'booking_date')
  String? bookingDate;
  @JsonKey(name: 'row')
  String? row;
  @JsonKey(name: 'seat')
  String? seat;
  @JsonKey(name: 'total_seat')
  int? totalSeat;
  @JsonKey(name: 'total')
  String? total;
  @JsonKey(name: 'movie_id')
  int? movieId;
  @JsonKey(name: 'cinema_id')
  int? cinemaId;
  @JsonKey(name: 'username')
  String? userName;
  @JsonKey(name: 'timeslot')
  TimeSlotVO? timeslot;
  @JsonKey(name: 'snacks')
  List<SnackListVO>? snacks;

  CheckoutVO(
      this.id,
      this.bookingNo,
      this.bookingDate,
      this.row,
      this.seat,
      this.totalSeat,
      this.total,
      this.movieId,
      this.cinemaId,
      this.userName,
      this.timeslot,
      this.snacks);

  factory CheckoutVO.fromJson(Map<String, dynamic> json) =>
      _$CheckoutVOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutVOToJson(this);
}