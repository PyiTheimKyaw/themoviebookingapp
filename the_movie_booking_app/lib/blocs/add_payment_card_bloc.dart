import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

class AddPaymentCardBloc extends ChangeNotifier{
  ///Model
  MovieModel mMovieModel=MovieModelImpl();
  AddPaymentCardBloc();
  Future<UserVO?> createUserCard(String num,String holder,String date,String cvc){
    // return mMovieModel.postCreateCard(num, holder, date, cvc);
     return mMovieModel.postCreateCard(num, holder, date, cvc).then((value) {
      mMovieModel.getProfile();
    });
  }
  Future<UserVO> getProfile(){
    return mMovieModel.getProfile();
  }

}