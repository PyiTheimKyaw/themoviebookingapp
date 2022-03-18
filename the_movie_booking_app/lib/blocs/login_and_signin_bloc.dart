import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';

import '../data/vos/user_vo.dart';

class LoginAndSignInBloc extends ChangeNotifier {
  ///State
  Map<String, dynamic>? userDataInfo;
  AccessToken? accessToken;

  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  LoginAndSignInBloc();

  Future<UserVO> onTapRegisterWithGmailAndFacebook(
      String name,
      String email,
      String phNum,
      String password,
      String? googleToken,
      String? facebookToken) {
    return mMovieModel.registerWithEmail(
        name, email, phNum, password, googleToken, facebookToken);
  }

  Future<UserVO> onTapLoginWithEmail(String email, String password) {
    return mMovieModel.loginWithEmail(email, password);
  }

  Future<UserVO> onTapLoginWitFacebook(String accessToken) {
    return mMovieModel.loginWithFacebook(accessToken);
  }

  Future<UserVO> onTapLoginWithGoogle(String accessToken) {
    return mMovieModel.loginWithGoogle(accessToken);
  }

  Future<void> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile

    if (result.status == LoginStatus.success) {
      accessToken = result.accessToken;

      final userData =
          await FacebookAuth.instance.getUserData(fields: "email,name");
      userDataInfo = userData;
    } else {
      print(result.status);
      print(result.message);
    }
  }
}
