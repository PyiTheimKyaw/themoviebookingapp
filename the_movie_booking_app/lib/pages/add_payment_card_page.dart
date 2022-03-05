// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';

TextEditingController numController = TextEditingController();
TextEditingController holderController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController cvcController = TextEditingController();

class AddPaymentCardPage extends StatefulWidget {
  const AddPaymentCardPage({Key? key}) : super(key: key);

  @override
  State<AddPaymentCardPage> createState() => _AddPaymentCardPageState();
}

class _AddPaymentCardPageState extends State<AddPaymentCardPage> {
  MovieModel mMovieModel = MovieModelImpl();
  List<UserVO>? user;
  List<CardVO>? cardInfo;

  @override
  void initState() {
    mMovieModel.getLoginUserIfoDatabase().listen((userInfo) {
      setState(() {
        user = userInfo;
      });
      print('user at neww card ${user?.first.token}');
    }).onError((error){
      print("Error at user data from database ${error.toString()}");
    });
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
            mMovieModel
                .postCreateCard(
                    user?[0].Authorization() ?? "",
                    numController.text,
                    holderController.text,
                    dateController.text,
                    cvcController.text)
                .then((value) {
                 mMovieModel.getProfileFromDatabase(user?[0].Authorization() ?? "").listen((event) {
                   Navigator.pop(context);

                 });
            });
            print('user at tap card ${user?.first.token}');

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
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          icon: Icon(
            Icons.chevron_left,
            size: 34,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CardInfoSectionView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardInfoSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserInputFields(
          card: 'Card Number',
          inputController: numController,
        ),
        SizedBox(
          height: MARGIN_LARGE,
        ),
        UserInputFields(
          card: 'Card Holder',
          inputController: holderController,
        ),
        SizedBox(
          height: MARGIN_LARGE,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: UserInputFields(
                card: 'Expiration Date',
                inputController: dateController,
              ),
            ),
            SizedBox(
              width: MARGIN_MEDIUM_2,
            ),
            Expanded(
              flex: 1,
              child: UserInputFields(
                card: 'CVC',
                inputController: cvcController,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UserInputFields extends StatelessWidget {
  final String card;
  TextEditingController inputController = TextEditingController();

  UserInputFields({required this.card, required this.inputController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      decoration: InputDecoration(
        labelText: card,
        labelStyle:
            TextStyle(color: MOVIE_CINEMA_COLOR, fontWeight: FontWeight.w500),
      ),
    );
  }
}