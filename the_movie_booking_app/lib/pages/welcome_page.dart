// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/login_and_sign_in_page.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
import 'package:the_movie_booking_app/widgets/blur_title_text_view.dart';
import 'package:the_movie_booking_app/widgets/title_text_view.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<UserVO>? userList;
  List<SnackListVO>? snackLis;
  MovieModel mMovieModel = MovieModelImpl();

  @override
  void initState() {
    ///User from database
    mMovieModel.getLoginUserIfoDatabase().listen((value) {
      setState(() {
        userList = value;
      });

      if (userList?[0].token != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    userData: null,
                    googleId: "",
                  )),
        );
      }
    }).onError((error){
      print("User data error at welcome page ${error.toString()}");
    });

    ///Snack list from database

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: PRIMARY_COLOR,
          child: Padding(
            padding: const EdgeInsets.only(top: MARGIN_XXLARGE),
            child: Column(
              children: [
                WelcomePageImageSectionView(),
                WelcomePageTextSectionView(),
                Spacer(),
                GetStartedButtonSectionView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GetStartedButtonSectionView extends StatelessWidget {
  const GetStartedButtonSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MARGIN_LARGE),
      width: MediaQuery.of(context).size.width * 0.93,
      height: FLOATING_ACTION_BUTTON_HEIGHT,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginAndSignInPage(),
            ),
          );
        },
        child: Text(
          WELCOME_SCREEN_GET_STARTED_TEXT,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class WelcomePageImageSectionView extends StatelessWidget {
  const WelcomePageImageSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/welome.png',
    );
  }
}

class WelcomePageTextSectionView extends StatelessWidget {
  const WelcomePageTextSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MARGIN_LARGE),
        ),
        TitleText(WELCOME_SCREEN_WELCOME_TEXT),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        BlurTitleText(WELCOME_TO_GALAXY_APP_TEXT, WELCOME_SCREEN_TEXT_COLOR),
      ],
    );
  }
}
