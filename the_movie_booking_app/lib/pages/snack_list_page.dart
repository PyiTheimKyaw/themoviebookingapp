// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/models/snack_request.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/pages/payment_card_page.dart';
import 'package:the_movie_booking_app/pages/welcome_page.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/widgets/floating_action_button_view.dart';
import 'package:the_movie_booking_app/widgets/title_text_view.dart';

class SnackListPage extends StatefulWidget {
  final double price;
  final String dateData;
  final String userChooseTime;
  final String userChooseCinema;
  final int userChooseDayTimeslotId;
  final int cinemaId;
  final String movieName;
  final int movieId;
  final String token;
  final String seatNo;

  SnackListPage(
      {required this.price,
      required this.dateData,
      required this.userChooseTime,
      required this.userChooseCinema,
      required this.userChooseDayTimeslotId,
      required this.cinemaId,
      required this.movieName,
      required this.movieId,
      required this.token,
      required this.seatNo});

  @override
  State<SnackListPage> createState() => _SnackListPageState();
}

class _SnackListPageState extends State<SnackListPage> {
  MovieModel mMovieModel = MovieModelImpl();
  List<SnackListVO>? snacks;
  List<PaymentMethodVO>? paymentMethod;
  List<UserVO>? user;
  List<SnackRequest>? snackList = [];
  double subTotal = 0;

  @override
  void initState() {
    mMovieModel.getLoginUserIfoDatabase().listen((userInfo) {
      if (mounted) {
        setState(() {
          user = userInfo;
        });
      }

      ///Snack from database
      mMovieModel
          .getSnackListFromDatabase(user?.first.Authorization() ?? "")
          .listen((snack) {
        if (mounted) {
          setState(() {
            snacks = snack;
          });
        }
      }).onError((error) {
        print("Snack list error at home page ${error.toString()}");
      });
      mMovieModel
          .getPaymentMethodFromDatabase(user?.first.Authorization() ?? "")
          .listen((payment) {
        setState(() {
          paymentMethod = payment;
        });
        print('Succes payment method api ');
      });
    }).onError((error) {
      print("User data error at snack page ${error.toString()}");
    });

    subTotal = widget.price;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
        width: MediaQuery.of(context).size.width * 0.93,
        height: FLOATING_ACTION_BUTTON_HEIGHT,
        child: FloatingActionButton.extended(
          backgroundColor: PRIMARY_COLOR,
          onPressed: () {
            setState(() {
              // snacks?.map((snack) {
              //   if(snack.quantity == 0){
              //     snackList.add(SnackRequest(snack.id ?? 0, snack.quantity ?? 0));
              //   }
              // });
              List<SnackListVO>? temp =
                  snacks?.where((element) => element.quantity != 0).toList();
              snackList = temp
                  ?.map((e) => SnackRequest(e.id ?? 0, e.quantity ?? 0))
                  .toList();
              // temp?.map((snack) {
              //   snackList.add(SnackRequest(snack.id ?? 1, snack.quantity ?? 1));
              // });
              print(
                  'Snack list where quantity is greater than 0 => ${temp?[0].name}');
              print('Snack List after condition ==> $snackList');
            });

            // snackList?.add(SnackRequest(id, quantity));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentCardPage(
                  totalPrice: subTotal,
                  cinemaId: widget.cinemaId,
                  userChooseCinema: widget.userChooseCinema,
                  userChooseDayTimeslotId: widget.userChooseDayTimeslotId,
                  userChooseTime: widget.userChooseTime,
                  dateData: widget.dateData,
                  movieName: widget.movieName,
                  movieId: widget.movieId,
                  token: widget.token,
                  seatNo: widget.seatNo,
                  snack: snackList,
                ),
              ),
            );
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => widget));
          },
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          label: Text(
            'Pay \$$subTotal',
            style: TextStyle(
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.chevron_left,
            size: MARGIN_LARGE,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_4,
          vertical: MARGIN_MEDIUM,
        ),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SnackItemListAndCountSectionView(
                snack: snacks,
                decrease: (snack) {
                  setState(() {
                    if ((snack?.quantity ?? 0) > 0) {
                      subTotal -= snack?.price ?? 0;
                    }
                    snacks?.forEach((element) {
                      if (element.id == snack?.id) {
                        if ((element.quantity ?? 0) > 0) {
                          element.quantity = (element.quantity ?? 0) - 1;
                        }
                      }
                    });
                  });
                },
                increase: (snack) {
                  setState(() {
                    snacks?.forEach((element) {
                      if (element.id == snack?.id) {
                        element.quantity = (element.quantity ?? 0) + 1;
                      }
                    });
                    subTotal += snack?.price ?? 0;
                  });
                },
              ),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              PromoCodeAndSubTotalSectionView(
                total: subTotal,
              ),
              SizedBox(
                height: MARGIN_MEDIUM_3,
              ),
              PaymentMethodSectionView(
                payment: paymentMethod,
                onTapPayment: (pay) {
                  setState(() {
                    // paymentMethod?.forEach((element) {
                    //   if(element.id==pay?.id){
                    //     element.isSelected=true;
                    //   }else{
                    //     element.isSelected=false;
                    //   }
                    // });
                    paymentMethod?.forEach((element) {
                      element.isSelected = false;
                    });
                    paymentMethod?[pay!].isSelected = true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodSectionView extends StatelessWidget {
  final List<PaymentMethodVO>? payment;
  final Function(int?) onTapPayment;

  PaymentMethodSectionView({required this.payment, required this.onTapPayment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(color: Colors.black, fontSize: TEXT_REGULAR_1X),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return PaymentTypeView(
              payment: payment,
              index: index,
              onTap: onTapPayment,
            );
          },
        ),
        // PaymentTypeView('Credit Card', 'Visa,Master card,JCB'),
        // PaymentTypeView('Internet Banking(ATM Card)', 'Visa,Master card,JCB'),
        // PaymentTypeView('E-wallet', 'Paypal'),
      ],
    );
  }
}

class PaymentTypeView extends StatelessWidget {
  final List<PaymentMethodVO>? payment;
  final int index;
  final Function(int?) onTap;

  PaymentTypeView(
      {required this.payment, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        //  minLeadingWidth: 22,
        leading: Icon(
          Icons.payment,
          color: (payment?[index].isSelected == true)
              ? PRIMARY_COLOR
              : Colors.black,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              payment?[index].name ?? "",
              style: TextStyle(
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w400,
                color: (payment?[index].isSelected == true)
                    ? PRIMARY_COLOR
                    : Colors.black,
              ),
            ),
            Text(
              payment?[index].description ?? "",
              style: TextStyle(
                color: (payment?[index].isSelected == true)
                    ? PRIMARY_COLOR
                    : MOVIE_CINEMA_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromoCodeAndSubTotalSectionView extends StatelessWidget {
  double total;

  PromoCodeAndSubTotalSectionView({required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter promo code',
            hintStyle: TextStyle(
              color: MOVIE_CINEMA_COLOR,
            ),
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Row(
          children: [
            Text(
              'Don\'t have any promo code?',
              style: TextStyle(color: MOVIE_CINEMA_COLOR),
            ),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Text(
              'Get it now',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Text(
          'Sub Total:$total\$',
          style: TextStyle(
              color: Color.fromRGBO(19, 210, 26, 1.0),
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class SnackItemListAndCountSectionView extends StatelessWidget {
  final List<SnackListVO>? snack;

  final Function(SnackListVO?) decrease;
  final Function(SnackListVO?) increase;

  SnackItemListAndCountSectionView(
      {required this.snack, required this.decrease, required this.increase});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: snack?.length ?? 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(bottom: MARGIN_MEDIUM_3),
            child: Column(
              children: [
                // SnackMenuAndCashView(),
                Container(
                  margin: EdgeInsets.only(right: MARGIN_MEDIUM_3),
                  child: Row(
                    children: [
                      Text(
                        snack?[index].name ?? "",
                        style: TextStyle(
                          fontSize: TEXT_REGULAR,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${snack?[index].price ?? 0}\$',
                        style: TextStyle(
                          fontSize: TEXT_REGULAR,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                SnackItemAndQuantityView(
                  snack: snack,
                  index: index,
                  decrease: decrease,
                  increase: increase,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SnackItemAndQuantityView extends StatelessWidget {
  final List<SnackListVO>? snack;
  final int index;

  final Function(SnackListVO?) decrease;
  final Function(SnackListVO?) increase;

  SnackItemAndQuantityView(
      {required this.snack,
      required this.index,
      required this.decrease,
      required this.increase});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.end,

      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            snack?[index].description ?? "",
            style: TextStyle(color: MOVIE_CINEMA_COLOR),
          ),
        ),
        Spacer(),
        Container(
          width: SNACK_ITEM_COUNT_WIDTH,
          height: SNACK_ITEM_COUNT_HEIGHT,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 1,
              color: Colors.black54,
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  decrease(snack?[index]);
                },
                child: Container(
                  width: MARGIN_MEDIUM_4,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(width: 1, color: Colors.black54),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      size: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                width: MARGIN_MEDIUM_4,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1, color: Colors.black54),
                  ),
                ),
                child: Center(
                  child: Text('${snack?[index].quantity ?? 0}'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  increase(snack?[index]);
                },
                child: Container(
                  width: MARGIN_MEDIUM_4,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // ItemCountView(
        //   snackList: widget.snack,
        //   index: widget.index,
        //   quantity: widget.quantity,
        //   decrease: widget.decrease(widget.index),
        //   increase: widget.increase(widget.index),
        // ),
      ],
    );
  }
}

class ItemCountView extends StatefulWidget {
  final List<SnackListVO>? snackList;
  final int index;
  final int quantity;
  final Function(int) decrease;
  final Function(int) increase;

  ItemCountView(
      {required this.snackList,
      required this.index,
      required this.quantity,
      required this.decrease,
      required this.increase});

  @override
  State<ItemCountView> createState() => _ItemCountViewState();
}

class _ItemCountViewState extends State<ItemCountView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SNACK_ITEM_COUNT_WIDTH,
      height: SNACK_ITEM_COUNT_HEIGHT,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: Colors.black54,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              widget.decrease(widget.index);
            },
            child: Container(
              width: MARGIN_MEDIUM_4,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: Colors.black54),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.remove,
                  size: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            width: MARGIN_MEDIUM_4,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1, color: Colors.black54),
              ),
            ),
            child: Center(
              child: Text(
                  widget.snackList?[widget.index].quantity.toString() ?? ""),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.increase(widget.index);
            },
            child: Container(
              width: MARGIN_MEDIUM_4,
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SnackMenuAndCashView extends StatelessWidget {
  const SnackMenuAndCashView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_3),
      child: Row(
        children: [
          Text(
            'Combo set M',
            style: TextStyle(
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          Text(
            '15\$',
            style: TextStyle(
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
