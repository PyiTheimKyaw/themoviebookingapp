import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/models/snack_request.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:collection/collection.dart';

class SnackListBloc extends ChangeNotifier {
  ///State
  List<SnackListVO>? mSnacksList;
  List<PaymentMethodVO>? mPaymentMethod;
  List<UserVO>? user;
  List<SnackRequest>? snackList = [];
  double subTotal = 0;
  bool notify=false;

  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  SnackListBloc(double total,[MovieModel? movieModel]) {
    if(movieModel!=null){
      mMovieModel=movieModel;
    }
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
  void onTapDecreaseSnack(int snack){
    if ((mSnacksList?[snack].quantity ?? 0) > 0) {
      subTotal -= mSnacksList?[snack].price ?? 0;
      notifyListeners();
    }
    mSnacksList=mSnacksList?.map((element) {
      if (element.id == mSnacksList?[snack].id) {
        if ((element.quantity ?? 0) > 0) {
          element.quantity = (element.quantity ?? 0) - 1;
        }
      }
      return element;
    }).toList();
    notifyListeners();
  }

  void onTapIncreaseSnack(int snack){
    mSnacksList=mSnacksList?.map((element) {
      if (element.id == mSnacksList?[snack].id) {
        element.quantity = (element.quantity ?? 0) + 1;
      }
      return element;
    }).toList();
    subTotal += mSnacksList
        ?[0].price ?? 0;
    notifyListeners();
  }
  void selectPayment(int? pay){
    // (notify ==false) ? notify=true : notify =false;
    // print("Notify $notify");
    // notifyListeners();

    // mPaymentMethod?.forEach((element) {
    //   element.isSelected = false;
    // });
   List<PaymentMethodVO>? paymentMethod= mPaymentMethod?.map((e) {
      e.isSelected=false;
      return e;
    }).mapIndexed((index, element) {
      if(index==pay) {
        mPaymentMethod?[index].isSelected = true;
      }else{
        mPaymentMethod?[index].isSelected = false;
      }
      return element;
   }).toList();
   mPaymentMethod=paymentMethod;
   notifyListeners();
    // if(pay != null) {
    //   paymentMethod?[pay].isSelected = true;
    //   mPaymentMethod=paymentMethod;
    //   notifyListeners();
    // }
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
