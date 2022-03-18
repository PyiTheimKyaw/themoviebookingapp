import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/models/snack_request.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

class SnackListBloc extends ChangeNotifier {
  ///State
  List<SnackListVO>? mSnacksList;
  List<PaymentMethodVO>? mPaymentMethod;
  List<UserVO>? user;
  List<SnackRequest>? snackList = [];
  double subTotal = 0;
  int notify=0;

  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  SnackListBloc(double total) {
    subTotal=total;
    ///User
    mMovieModel.getLoginUserIfoDatabase().listen((userInfo) {
      user = userInfo;
      notifyListeners();
    }).onError((error) {});

    ///Payment Method
    mMovieModel.getPaymentMethodFromDatabase().listen((payment) {
      mPaymentMethod = payment;
      notifyListeners();
      print('Succes payment method api ');
    }).onError((error) {});

    ///Snack from database
    mMovieModel.getSnackListFromDatabase().listen((snack) {
      mSnacksList = snack;
      notifyListeners();
    }).onError((error) {
      print("Snack list error at home page ${error.toString()}");
    });
  }
  void onTapDecreaseSnack(SnackListVO? snack){
    if ((snack?.quantity ?? 0) > 0) {
      subTotal -= snack?.price ?? 0;
      notifyListeners();
    }
    mSnacksList?.forEach((element) {
      if (element.id == snack?.id) {
        if ((element.quantity ?? 0) > 0) {
          element.quantity = (element.quantity ?? 0) - 1;
        }
      }
    });
  }

  void onTapIncreaseSnack(SnackListVO? snack){
    mSnacksList?.forEach((element) {
      if (element.id == snack?.id) {
        element.quantity = (element.quantity ?? 0) + 1;
      }
    });
    subTotal += snack?.price ?? 0;
    notifyListeners();
  }
  void selectPayment(int? pay){
    notify++;
    print("Notify $notify");
    notifyListeners();
    mPaymentMethod?.forEach((element) {
      element.isSelected = false;
    });
    mPaymentMethod?[pay!].isSelected = true;
    notifyListeners();
  }
  void onPressedPayment(){

    List<SnackListVO>? temp =
    mSnacksList?.where((element) => element.quantity != 0).toList();
    snackList = temp
        ?.map((e) => SnackRequest(e.id ?? 0, e.quantity ?? 0))
        .toList();
    notifyListeners();
  }
}
