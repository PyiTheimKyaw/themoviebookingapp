import 'package:the_movie_booking_app/data/vos/movie_vo.dart';

abstract class MovieDao{
  void saveMovies(List<MovieVO> movies);
  void saveSingleMovie(MovieVO movie);
  List<MovieVO> getAllMovies();
  MovieVO? getMovieById(int movieId);
  Stream<void> getAllMoviesEventStream();
  MovieVO? getMovieDetails(int movieId);
  List<MovieVO> getNowPlayingMovies();
  List<MovieVO> getComingSoonMovies();
  Stream<MovieVO?> getMovieDetailsStream(int movieId);
  Stream<List<MovieVO>> getNowPlayingMoviesStream();
  Stream<List<MovieVO>> getComingSoonMoviesStream();
}