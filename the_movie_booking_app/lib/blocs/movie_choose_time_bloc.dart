import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

import 'package:collection/collection.dart';

class MovieChooseTimeBloc extends ChangeNotifier {
  ///State
  List<CinemaDayTimeSlotVO>? mCinemaInfo;
  List<UserVO>? mUserData;
  String? dateData;
  String? userChooseTime;
  String? userChooseCinema;
  int? userChoosedayTimeslotId;
  int? cinemaId;

  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  MovieChooseTimeBloc(String movieId) {
    dateData = DateTime.now().toString().split(" ")[0];

    ///Get User
    mMovieModel.getLoginUserIfoDatabase().listen((userInfo) {
      mUserData = userInfo ?? [];
      notifyListeners();
    }).onError((error) {
      print("Userdata error at choose age ${error.toString()}");
    });

    ///Get Cinema Day Time Slot
    mMovieModel
        .getCinemaDayTimeslotFromDatabase(
            mUserData?.first.Authorization() ?? "",
            movieId,
            dateData?.split("")[0] ?? DateTime.now().toString().split(" ")[0])
        .listen((value) {
      mCinemaInfo = value?.cinemaList ?? [];
      notifyListeners();
    }).onError((error) {
      print(
          "Cinema dau time slot error default date at choose time page ${error.toString()}");
    });
  }

  void getSelectedDate(String movieId, String? date) {
    dateData = date;
    notifyListeners();
    getNewTimeslots(movieId);
  }

  void getNewTimeslots(String movieId) {
    mMovieModel
        .getCinemaDayTimeslotFromDatabase(
            mUserData?.first.Authorization() ?? "",
            movieId,
            dateData?.split("")[0] ?? DateTime.now().toString().split(" ")[0])
        .listen((value) {
      mCinemaInfo = value?.cinemaList ?? [];
      notifyListeners();
    }).onError((error) {
      print(
          "Cinema dau time slot error choose date at choose time page ${error.toString()}");
    });
  }

  void onTapChooseTime(int firstIndex, int secIndex) {
    // mCinemaInfo?.forEach((outer) {
    //   outer.timeSlots?.forEach((inner) {
    //     inner.isSelected = false;
    //   });
    // });

    mCinemaInfo = mCinemaInfo?.mapIndexed((i, outer) {
      outer.timeSlots?.mapIndexed((j, inner) {
        inner.isSelected = false;
        if (i == firstIndex && j == secIndex) {
          inner.isSelected = true;
          mCinemaInfo?[firstIndex].timeSlots?[secIndex].isSelected = true;

          userChooseTime =
              mCinemaInfo?[firstIndex].timeSlots?[secIndex].startTime;

          userChooseCinema = mCinemaInfo?[firstIndex].cinema;

          userChoosedayTimeslotId =
              mCinemaInfo?[firstIndex].timeSlots?[secIndex].cinemaDayTimeSlotId;

          cinemaId = mCinemaInfo?[firstIndex].cinemaId;
        }
        return inner;
      }).toList();
      return outer;
    }).toList();
    notifyListeners();

    notifyListeners();
  }
}
