// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/snack_list_bloc.dart';
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

class SnackListPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SnackListBloc(price),
      child: Scaffold(
        floatingActionButton: Selector<SnackListBloc, double>(
          selector: (context, bloc) => bloc.subTotal,
          builder: (context, subTotal, child) => Container(
            margin: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
            width: MediaQuery.of(context).size.width * 0.93,
            height: FLOATING_ACTION_BUTTON_HEIGHT,
            child: FloatingActionButton.extended(
              backgroundColor: PRIMARY_COLOR,
              onPressed: () {
                SnackListBloc bloc =
                Provider.of<SnackListBloc>(context, listen: false);
                bloc.onPressedPayment();

                // snackList?.add(SnackRequest(id, quantity));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentCardPage(
                      totalPrice: subTotal,
                      cinemaId: cinemaId,
                      userChooseCinema: userChooseCinema,
                      userChooseDayTimeslotId: userChooseDayTimeslotId,
                      userChooseTime: userChooseTime,
                      dateData: dateData,
                      movieName: movieName,
                      movieId: movieId,
                      token: token,
                      seatNo: seatNo,
                      snack: bloc.snackList,
                    ),
                  ),
                );

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
                Selector<SnackListBloc, List<SnackListVO>?>(
                  selector: (context, bloc) => bloc.mSnacksList,
                  builder: (context, snacks, child) =>
                      Selector<SnackListBloc, double>(
                        selector: (context, bloc) => bloc.subTotal,
                        builder: (context, subTotal, child) =>
                            SnackItemListAndCountSectionView(
                              snack: snacks,
                              decrease: (snack) {
                                SnackListBloc bloc =
                                Provider.of<SnackListBloc>(context, listen: false);
                                bloc.onTapDecreaseSnack(snack);
                              },
                              increase: (snack) {
                                SnackListBloc bloc =
                                Provider.of<SnackListBloc>(context, listen: false);
                                bloc.onTapIncreaseSnack(snack);
                              },
                            ),
                      ),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Selector<SnackListBloc, double>(
                  selector: (context, bloc) => bloc.subTotal,
                  builder: (context, subTotal, child) =>
                      PromoCodeAndSubTotalSectionView(
                        total: subTotal,
                      ),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM_3,
                ),
                Selector<SnackListBloc, List<PaymentMethodVO>?>(
                  selector: (context, bloc) => bloc.mPaymentMethod,
                  builder: (context, paymentMethod, child) =>
                      Selector<SnackListBloc, bool>(
                        selector: (context, bloc) => bloc.notify,
                        builder: (context, notify, child) =>
                            PaymentMethodSectionView(
                              payment: paymentMethod,
                              onTapPayment: (pay) {
                                SnackListBloc bloc =
                                Provider.of<SnackListBloc>(context, listen: false);
                                bloc.selectPayment(pay);
                              },
                            ),
                      ),
                ),
              ],
            ),
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
          itemCount: payment?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return PaymentTypeView(
              payment: payment,
              index: index,
              onTap: onTapPayment,
            );
          },
        ),

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
