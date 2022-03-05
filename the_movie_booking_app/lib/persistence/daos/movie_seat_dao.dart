import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class MovieSeatDao{
  static final MovieSeatDao _singleton=MovieSeatDao.internal();
  factory MovieSeatDao(){
    return _singleton;
  }
  MovieSeatDao.internal();

  void saveMovieSeats(List<MovieSeatVO> seat) async{
    Map<int,MovieSeatVO> allMovieSeats=Map.fromIterable(seat,key: (seats) => seats.id,value: (seats) => seats);
    return getMovieSeatBox().putAll(allMovieSeats);
  }
  List<MovieSeatVO> getMovieSeats(){
    return getMovieSeatBox().values.toList();
  }
  Box<MovieSeatVO> getMovieSeatBox(){
    return Hive.box<MovieSeatVO>(BOX_NAME_MOVIE_SEAT_VO);
  }
}