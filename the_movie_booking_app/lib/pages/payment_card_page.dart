// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/checkout_request.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/models/snack_request.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/checkout_vo.dart';
import 'package:the_movie_booking_app/data/vos/profile_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/pages/add_payment_card_page.dart';
import 'package:the_movie_booking_app/pages/voucher_page.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:the_movie_booking_app/widgets/floating_action_button_view.dart';
import 'package:the_movie_booking_app/widgets/title_text_view.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

int? cardId;

class PaymentCardPage extends StatefulWidget {
  final double totalPrice;
  final String dateData;
  final String userChooseTime;
  final String userChooseCinema;
  final int userChooseDayTimeslotId;
  final int cinemaId;
  final String movieName;
  final int movieId;
  final String token;
  final String seatNo;
  final List<SnackRequest>? snack;

  PaymentCardPage({
    required this.totalPrice,
    required this.dateData,
    required this.userChooseTime,
    required this.userChooseCinema,
    required this.userChooseDayTimeslotId,
    required this.cinemaId,
    required this.movieName,
    required this.movieId,
    required this.token,
    required this.seatNo,
    required this.snack,
  });

  @override
  State<PaymentCardPage> createState() => _PaymentCardPageState();
}

class _PaymentCardPageState extends State<PaymentCardPage> {
  List<CardVO>? cardList;
  MovieModel mMovieModel = MovieModelImpl();
  UserVO? profileInfo;
  List<UserVO>? user;
  UserVO? userInfo;
  CardVO? chooseCard;
  CheckoutVO? checkoutVO;

  @override
  void initState() {

    // mMovieModel
    //     .getProfileFromDatabase(
    //     user?.first.Authorization() ?? "")
    //     .listen((profile) {
    //   if(mounted) {
    //     setState(() {
    //       user=profile;
    //       cardList = profile?.first.cards ?? [];
    //     });
    //     cardId = cardList?.first.id ?? 0;
    //     print("token at payment page ${cardList}");
    //   }
    //   // mMovieModel.getCardsFromDatabase().listen((event) {
    //   //   if (mounted) {
    //   //     setState(() {
    //   //       cardList = event;
    //   //     });
    //   //   }
    //   //   print('card owner $cardList');
    //   // });
    //   // cardId = cardList?.first.id ?? 0;
    //   //  print('first card id ${cardList?.first.id ?? ""}');
    //   //  print(
    //   //      'Success  api call at card page ${user?.first.Authorization() ?? ""}');
    // });
    // print("User token at payment card page ${user?.first.token}");


    mMovieModel.getLoginUserIfoDatabase().listen((userInfo) {
      setState(() {
        user = userInfo;
      });
      mMovieModel
          .getProfileFromDatabase(
              user?.first.Authorization() ?? "")
          .listen((profile) {
            if(mounted) {
              setState(() {
                cardList = profile?[0].cards ?? [];
              });
            }
        print("token at payment from profile ${user?.first.Authorization()}");
            print("cardlist at payment ${cardList}");
        // mMovieModel.getCardsFromDatabase().listen((event) {
        //   if (mounted) {
        //     setState(() {
        //       cardList = event;
        //     });
        //   }
        //   print('card owner $cardList');
        // });
         cardId = cardList?.first.id ?? 0;
        //  print('first card id ${cardList?.first.id ?? ""}');
        //  print(
        //      'Success  api call at card page ${user?.first.Authorization() ?? ""}');
      });
      print("User token at payment card page ${user?.first.token}");
    }).onError((error) {
      print("Userdata error at payment card page ${error.toString()}");
    });

    // mMovieModel
    //     .getProfile(user?.first.Authorization() ?? "")
    //     .then((profile) {
    //   // setState(() {
    //   //   cardList = profile?.cards;
    //   // });
    //   mMovieModel.getCardsFromDatabase().listen((card) {
    //     setState(() {
    //       cardList=card;
    //     });
    //     print('card owner $cardList');
    //   });
    //
    //
    // }).catchError((error){
    //   print("Profile error at card page ${error.toString()}");
    // });

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
            CheckOutRequest checkout = CheckOutRequest(
                widget.userChooseDayTimeslotId,
                widget.seatNo,
                widget.dateData.split(" ")[0],
                widget.movieId,
                widget.cinemaId,
                cardList?.first.id ?? 0,
                widget.snack);
            mMovieModel
                .checkout(user?.first.Authorization() ?? "", checkout)
                .then((value) {
              setState(() {
                checkoutVO = value;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VoucherPage(
                      price: widget.totalPrice,
                      cinemaId: widget.cinemaId,
                      userChooseCinema: widget.userChooseCinema,
                      userChooseDayTimeslotId: widget.userChooseDayTimeslotId,
                      userChooseTime: widget.userChooseTime,
                      dateData: widget.dateData,
                      movieName: widget.movieName,
                      movieId: widget.movieId,
                      token: widget.token,
                      cardId: chooseCard?.id ?? 0,
                      checkoutVO: checkoutVO,
                    ),
                  ),
                );
              });
            });

            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => widget));
          },
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          label: Text(
            'Confirm',
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
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaymentAmountSectionView(
                total: widget.totalPrice ?? 0,
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              PaymentCardSectionView(
                profile: cardList ?? [],
                swap: (index) {
                  setState(() {
                    cardId = cardList?[index].id;
                  });
                },
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              AddNewCardSectionView(
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPaymentCardPage()));
                  //     .then((value) {
                  //   if (value == true) {
                  //     mMovieModel
                  //         .getProfile(user?.first.Authorization() ?? "")
                  //         .then((result) {
                  //       setState(() {
                  //         cardList = result?.cards;
                  //       });
                  //     });
                  //   }
                  // });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewCardSectionView extends StatelessWidget {
  final Function onTapNewCard;

  AddNewCardSectionView(this.onTapNewCard);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapNewCard();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        child: Row(
          children: [
            Icon(
              Icons.add_circle_rounded,
              color: Colors.green,
              size: MARGIN_MEDIUM_4,
            ),
            SizedBox(
              width: MARGIN_MEDIUM_2,
            ),
            Text(
              'Add new card',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: TEXT_REGULAR),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentCardSectionView extends StatefulWidget {
  final List<CardVO>? profile;
  final Function(int) swap;

  PaymentCardSectionView({required this.profile, required this.swap});

  @override
  State<PaymentCardSectionView> createState() => _PaymentCardSectionViewState();
}

class _PaymentCardSectionViewState extends State<PaymentCardSectionView> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          widget.swap(index);
          // setState(() {
          //   cardId = widget.profile?[index].id;
          //   print('Card id when swap ==> ${cardId}');
          // });
        },
        height: PAYMENT_CARD_HEIGHT,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        // autoPlay: true,
        // autoPlayInterval: Duration(seconds: 3),
        // autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        // onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,
      ),
      items: widget.profile?.map(
        (card) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text(
                              card.cardType ?? "",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: TEXT_REGULAR_1X,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          card.cardNumber ?? "",
                          style: TextStyle(color: Colors.white, fontSize: 29),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'CARD HOLDER',
                                  style: TextStyle(
                                    color: MOVIE_CINEMA_COLOR,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'EXPIRES',
                                  style: TextStyle(color: MOVIE_CINEMA_COLOR),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MARGIN_MEDIUM,
                            ),
                            Row(
                              children: [
                                Text(
                                  card.cardHolder ?? "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: TEXT_REGULAR),
                                ),
                                Spacer(),
                                Text(
                                  card.expirationDate ?? "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: TEXT_REGULAR),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }
}

class PaymentAmountSectionView extends StatelessWidget {
  final double total;

  PaymentAmountSectionView({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Amount',
            style: TextStyle(
                color: MOVIE_CINEMA_COLOR,
                fontSize: TEXT_SMALL_1X,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TitleText(
            '\$ $total',
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}