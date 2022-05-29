import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/home_bloc.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
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
Map<String, dynamic> MOVIES_VIEW = {
  "DEFAULT_MOVIES_VIEW": const ConfigNowShowingAndComingSoonMoviesSectionView(),
  "CONFIG_MOVIES_VIEW_BY_TAB": const ConfigMoviesByTabSectionView(),
};
