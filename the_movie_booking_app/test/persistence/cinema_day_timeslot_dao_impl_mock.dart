import 'package:the_movie_booking_app/data/vos/cinema_list_for_hive_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/cinema_day_timeslot_dao.dart';

class CinemaDayTimeslotDaoImplMock extends CinemaDayTimeslotDao {
  Map<int?, CinemaListForHiveVO> cinemaTimeslotFromDatabaseMock = {};

  @override
  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date) {
    return cinemaTimeslotFromDatabaseMock.values.first;
  }

  @override
  Stream<void> getAllCinemaEventStream() {
    return Stream.value(null);
  }

  @override
  CinemaListForHiveVO? getCinema(String date) {
    return cinemaTimeslotFromDatabaseMock.values.first;
  }

  @override
  Stream<CinemaListForHiveVO?> getCinemaStream(String date) {
    return Stream.value(cinemaTimeslotFromDatabaseMock.values.first);
  }

  @override
  void saveCinemaDayTimeslot(CinemaListForHiveVO cinema, String date) {
    cinemaTimeslotFromDatabaseMock.values.first.cinemaList = cinema.cinemaList;
  }
}
