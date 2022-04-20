import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';

abstract class MovieSeatDao{
  void saveMovieSeats(List<MovieSeatVO> seat);
  List<MovieSeatVO> getMovieSeats();
}