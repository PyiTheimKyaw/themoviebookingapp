import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/google_signin.dart';

class HomeBloc extends ChangeNotifier {
  List<MovieVO>? mNowPlayingMovies;
  List<MovieVO>? mComingSoonMovies;
  List<UserVO>? mUserInfo;
  List<SnackListVO>? mSnackList;
  MovieModel mMovieModel = MovieModelImpl();
  bool isDispose = false;

  HomeBloc([MovieModel? movieModel]) {
    if (movieModel != null) {
      mMovieModel = movieModel;
    }

    ///User from database
    mMovieModel.getLoginUserIfoDatabase().listen((user) {
      mUserInfo = user;
      notifyListeners();
    }).onError((error) {
      debugPrint('Error ======> ${error.toString()}');
    });

    ///Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      mNowPlayingMovies = movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint('Error ======> ${error.toString()}');
    });

    ///Coming Soon Movies Database
    mMovieModel.getComingSoonMoviesFromDatabase().listen((movieList) {
      mComingSoonMovies = movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint('Error ======> ${error.toString()}');
    });

    mMovieModel.getSnackList();
  }

  Future<void> onTapLogoutUser() {
    return mMovieModel.logoutUserFromDatabase();
  }

  Future<void> logOutFacebook() async {
    await FacebookAuth.instance.logOut();
    // _accessToken = null;
    // widget.userData = null;
  }

  Future<void> onTapGoogleLogOut() {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    return googleSignIn.signOut().then((value) {
      print('Google logout successfully');
    }).catchError((error) {
      print('Google logout failed ${error.toString()}');
    });
  }

  bool notifySafely() {
    if (!isDispose) {
      print("notifySafely ======> $isDispose");
      notifyListeners();
    }
    return isDispose;
  }
}
