import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';

class MovieDetailsBloc extends ChangeNotifier {
  ///State
  MovieVO? mMovieDetails;
  List<CreditVO>? mCast;

  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId) {
    ///Movie Details Database
    mMovieModel.getMovieDetailsFromDatabase(movieId).listen((movieDetails) {
      mMovieDetails = movieDetails;
      notifyListeners();
      // print('Movie id ${movieDetails?.releaseDate ?? ""}');
    }).onError((error) {
      print("Movie details error at voucher page ${error.toString()}");
    });

    ///CreditsByMovie
    mMovieModel.getCreditsFromDatabase(movieId).listen((cast) {
      mCast = cast;
      notifyListeners();
      // print('Cast ${mCast?.first.id}');
    }).onError((error) {
      debugPrint(error.toString());
    });
  }
}
