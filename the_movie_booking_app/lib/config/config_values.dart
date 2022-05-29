import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/home_bloc.dart';
import 'package:the_movie_booking_app/blocs/movie_details_bloc.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
import 'package:the_movie_booking_app/widgets/cast_by_wrap.dart';
import 'package:the_movie_booking_app/widgets/cast_section_view.dart';
import 'package:the_movie_booking_app/widgets/config_movies_by_tab_section_view.dart';
import 'package:the_movie_booking_app/widgets/config_now_showing_and_coming_soon_movies_section_view.dart';

const Map<String, dynamic> THEME_COLORS = {
  "DEFAULT_THEME_COLOR": Color.fromRGBO(98, 62, 234, 1.0),
  "CONFIG_COLOR": Color.fromRGBO(22, 28, 36, 1.0),
};

const Map<String, String> WELCOME_TITLE = {
  "DEFAULT_CONFIG_WELCOME_TITLE": "Galaxy",
  "CONFIG_WELCOME_SCREEN_TITLE": "The Movie Booking",
};

const Map<String, String> WELCOME_IMAGE = {
  "DEFAULT_WELCOME_IMAGE": 'images/welome.png',
  "CONFIG_WELCOME_SCREEN_IMAGE": "images/welcome2.png",
};
Map<String, bool> MOVIES_VIEW = {
  "DEFAULT_MOVIES_VIEW": false,
  "CONFIG_MOVIES_VIEW_BY_TAB": true,
};

Map<String, bool> CAST_VIEW = {
  "DEFAULT_CAST_VIEW": false,
  "CONFIG_CAST_BY_WRAP": true,
};
Map<String,dynamic> DATES_THEME_COLOR={
  "DEFAULT_DATES_THEME" :Colors.white,
  "CONFIG_DATES_COLOR" : Colors.yellow,
};
Map<String,bool> PAYMENT_CARD_VIEW={
  "DEFAULT_PAYMENT_CARD" : false,
  "CONFIG_PAYMENT_CARD" : true,
};