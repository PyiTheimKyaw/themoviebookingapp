
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_list_for_hive_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/welcome_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

import 'data/vos/collection_vo.dart';
import 'data/vos/credit_vo.dart';
import 'data/vos/date_vo.dart';
import 'data/vos/genre_vo.dart';
import 'data/vos/production_company_vo.dart';
import 'data/vos/production_country_vo.dart';
import 'data/vos/spoken_language_vo.dart';
import 'data/vos/timeslot_vo.dart';

void main() async {
  MovieModel movie = MovieModelImpl();
  await Hive.initFlutter();
  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());
  Hive.registerAdapter(CardVOAdapter());
  Hive.registerAdapter(SnackListVOAdapter());
  Hive.registerAdapter(CinemaDayTimeslotVOAdapter());
  Hive.registerAdapter(CinemaListForHiveVOAdapter());
  Hive.registerAdapter(MovieSeatVOAdapter());
  Hive.registerAdapter(TimeslotVOAdapter());
  Hive.registerAdapter(PaymentVOAdapter());
  Hive.registerAdapter(CreditVOAdapter());

  await Hive.openBox<UserVO>(BOX_NAME_USER_VO);
  await Hive.openBox<UserVO>(BOX_NAME_PROFILE_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<CreditVO>(BOX_NAME_CREDIT_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
  await Hive.openBox<SnackListVO>(BOX_NAME_SNACK_LIST_VO);
  await Hive.openBox<CinemaDayTimeSlotVO>(BOX_NAME_CINEMA_DAY_TIME_SLOT_VO);
  await Hive.openBox<CinemaListForHiveVO>(BOX_NAME_CINEMA_LIST_FOR_HIVE_VO);
  await Hive.openBox<MovieSeatVO>(BOX_NAME_MOVIE_SEAT_VO);
  await Hive.openBox<CardVO>(BOX_NAME_CARD_VO);
  await Hive.openBox<PaymentMethodVO>(BOX_NAME_PAYMENT_VO);
  await Hive.openBox<CreditVO>(BOX_NAME_CREDIT_VO);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: (userList != null )? HomePage() : WelcomePage()  ,

      home: WelcomePage(),
    );
  }
}


