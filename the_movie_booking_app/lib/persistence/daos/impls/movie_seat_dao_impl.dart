import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/movie_seat_dao.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class MovieSeatDaoImpl extends MovieSeatDao {
  static final MovieSeatDaoImpl _singleton = MovieSeatDaoImpl.internal();

  factory MovieSeatDaoImpl() {
    return _singleton;
  }

  MovieSeatDaoImpl.internal();

  @override
  void saveMovieSeats(List<MovieSeatVO> seat) async {
    Map<int, MovieSeatVO> allMovieSeats = Map.fromIterable(seat,
        key: (seats) => seats.id, value: (seats) => seats);
    return getMovieSeatBox().putAll(allMovieSeats);
  }

  @override
  List<MovieSeatVO> getMovieSeats() {
    return getMovieSeatBox().values.toList();
  }

  Box<MovieSeatVO> getMovieSeatBox() {
    return Hive.box<MovieSeatVO>(BOX_NAME_MOVIE_SEAT_VO);
  }
}
