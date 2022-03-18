import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';

class MovieSeatsBloc extends ChangeNotifier {
  ///State
  List<MovieSeatVO>? mMovieSeats;
  List<UserVO>? mUserInfo;
  List<String> pickSeat = [];
  double totalPrice = 0;
  int tickets = 0;

  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  MovieSeatsBloc(int timeSlotId, String date) {
    ///User From database
    mMovieModel.getLoginUserIfoDatabase().listen((user) {
      mUserInfo = user;
      notifyListeners();
    }).onError((error) {
      print("Userdata error at seat page ${error.toString()}");
    });

    ///Seat
    mMovieModel.getCinemaSeatingPlan(timeSlotId, date).then((seats) {
      mMovieSeats = seats;
      notifyListeners();
      print('Success seat choice');
    });

    mMovieModel.getMovieSeatsFromDatabase().then((value) {
      mMovieSeats = value;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onChooseSeat(MovieSeatVO? seat) {
    if (seat?.type == SEAT_TYPE_AVAILABLE) {
      List<MovieSeatVO>? tempSeats = mMovieSeats;
      tempSeats?.forEach((element) {
        if (element.id == seat?.id && element.symbol == seat?.symbol) {
          element.isSelected = (seat?.isSelected == false) ? true : false;
          notifyListeners();
        }
      });
      notifyListeners();
      if (seat?.isSelected == true) {
        pickSeat.add(seat?.seatName ?? "");
        totalPrice += seat?.price ?? 0;
        tickets++;
        notifyListeners();
      } else {
        pickSeat.remove(seat?.seatName ?? "");
        totalPrice -= seat?.price ?? 0;
        tickets--;
        notifyListeners();
      }

      mMovieSeats = tempSeats;
      notifyListeners();
    }
  }
}
