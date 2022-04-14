import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';

class VoucherBloc extends ChangeNotifier{
  ///State
  MovieVO? mMovieDetails;
  ///Model
  MovieModel mMovieModel=MovieModelImpl();
  VoucherBloc(int movieId){
    ///Movie Details Database
    mMovieModel
        .getMovieDetailsFromDatabase(movieId)
        .listen((movieDetails) {

          mMovieDetails = movieDetails;
          notifyListeners();
          // print('Movie id at voucher page ${movieDetails?.releaseDate ?? ""}');

    }).onError((error) {
      print("Movie details error at voucher page ${error.toString()}");
    });
  }
}