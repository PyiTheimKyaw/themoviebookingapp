import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/checkout_request.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/models/snack_request.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/checkout_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

class PaymentCardBloc extends ChangeNotifier {
  ///State
  List<CardVO>? cardList;

  List<UserVO>? user;

  CardVO? chooseCard;
  CheckoutVO? checkoutVO;

  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  PaymentCardBloc() {
    ///Profile
    mMovieModel.getProfileFromDatabase().listen((profile) {
      cardList = profile?.cards ?? [];
      notifyListeners();
    });
  }
  Future<CheckoutVO?> onTpCheckoutUser(int userChooseDayTimeslotId,String seatNo,String dateData,int movieId,int cinemaId,List<SnackRequest>? snack){
    CheckOutRequest checkOut = CheckOutRequest(
        userChooseDayTimeslotId,
        seatNo,
        dateData,
        movieId,
        cinemaId,
        cardList?.first.id ?? 0,
        snack);
   return mMovieModel.checkout(checkOut).then((value) {
     print("AApi output =>>>>>>> ${value}");
     checkoutVO=value;
     notifyListeners();
      return checkoutVO;
   });
  }
}
