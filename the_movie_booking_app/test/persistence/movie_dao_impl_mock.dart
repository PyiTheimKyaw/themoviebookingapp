import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/movie_dao.dart';

import '../mock_data/mock_data.dart';

class MovieDaoImplMock extends MovieDao {
  Map<int?, MovieVO> moviesFromDatabaseMock = {};

  @override
  List<MovieVO> getAllMovies() {
    return getMockMoviesForTest();
  }

  @override
  Stream<void> getAllMoviesEventStream() {
    return Stream.value(null);
  }

  @override
  List<MovieVO> getComingSoonMovies() {
    if (getMockMoviesForTest() != null && getMockMoviesForTest().isNotEmpty ??
        false) {
      return getMockMoviesForTest()
          .where((element) => element.isComingSoon ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getComingSoonMoviesStream() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if (getMockMoviesForTest() != null && getMockMoviesForTest().isNotEmpty ??
        false) {
      return getMockMoviesForTest()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  MovieVO? getMovieById(int movieId) {
    if (movieId != null) {
      return moviesFromDatabaseMock.values
          .toList()
          .firstWhere((element) => element.id == movieId);
    }
  }

  @override
  MovieVO? getMovieDetails(int movieId) {
    if (movieId != null) {
      return moviesFromDatabaseMock.values
          .toList()
          .firstWhere((element) => element.id == movieId);
    }
  }

  @override
  Stream<MovieVO?> getMovieDetailsStream(int movieId) {
    return Stream.value(moviesFromDatabaseMock.values
        .toList()
        .firstWhere((element) => element.id == movieId));
  }

  @override
  void saveMovies(List<MovieVO> movies) {
    movies.forEach((movie) {
      moviesFromDatabaseMock[movie.id] = movie;
    });
  }

  @override
  void saveSingleMovie(MovieVO movie) {
    if (movie != null) {
      moviesFromDatabaseMock[movie.id] = movie;
    }
  }
}
