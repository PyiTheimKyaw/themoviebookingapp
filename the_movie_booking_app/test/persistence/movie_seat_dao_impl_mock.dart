import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/movie_seat_dao.dart';

class MovieSeatDaoImplMock extends MovieSeatDao {
  Map<int?, MovieSeatVO> movieSeatsFromDatabaseMock = {};

  @override
  List<MovieSeatVO> getMovieSeats() {
    return movieSeatsFromDatabaseMock.values.toList();
  }

  @override
  void saveMovieSeats(List<MovieSeatVO> seat) {
    seat.forEach((seats) {
      movieSeatsFromDatabaseMock[seats.id] = seats;
    });
  }
}
