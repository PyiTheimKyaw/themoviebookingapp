// ignore_for_file: unnecessary_null_comparison

import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';

import '../hive_constants.dart';

class MovieDao {
  static final MovieDao _singleton = MovieDao.internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao.internal();

  void saveMovies(List<MovieVO> movies) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movies,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO movie) async {
    return getMovieBox().put(movie.id, movie);
  }

  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  MovieVO? getMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  ///Reactive Programming
  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  MovieVO? getMovieDetails(int movieId){
    if(getMovieById(movieId)!= null){
      return getMovieById(movieId);
    }
  }

  List<MovieVO> getNowPlayingMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((element) => element?.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  List<MovieVO> getComingSoonMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((element) => element?.isComingSoon ?? false)
          .toList();
    } else {
      return [];
    }
  }

  Stream<MovieVO?> getMovieDetailsStream(int movieId){
    return Stream.value(getMovieById(movieId));
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getAllMovies()
        .where((movieList) => movieList.isNowPlaying ?? false)
        .toList());
  }

  Stream<List<MovieVO>> getComingSoonMoviesStream() {
    return Stream.value(getAllMovies()
        .where((movieList) => movieList.isComingSoon ?? false)
        .toList());
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}
