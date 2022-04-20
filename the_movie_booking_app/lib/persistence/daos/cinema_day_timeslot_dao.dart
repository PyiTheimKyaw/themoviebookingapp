import 'package:the_movie_booking_app/data/vos/cinema_list_for_hive_vo.dart';

abstract class CinemaDayTimeslotDao{
  void saveCinemaDayTimeslot(CinemaListForHiveVO cinema,String date);
  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date);
  Stream<void> getAllCinemaEventStream();
  CinemaListForHiveVO? getCinema(String date);
  Stream<CinemaListForHiveVO?> getCinemaStream(String date);
}