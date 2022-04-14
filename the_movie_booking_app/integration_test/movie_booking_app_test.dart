// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_list_for_hive_vo.dart';
import 'package:the_movie_booking_app/data/vos/collection_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/date_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_company_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_country_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/spoken_language_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/main.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/login_and_sign_in_page.dart';
import 'package:the_movie_booking_app/pages/movie_details_page.dart';
import 'package:the_movie_booking_app/pages/welcome_page.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
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
  testWidgets("Test", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(Duration(seconds: 2));
    ///Welcome Page
    expect((find.byType(WelcomePage)), findsOneWidget);
    expect((find.text(TEST_DATA_WELCOME)), findsOneWidget);
    final getStartedButton=find.text(TEST_DATA_WELCOME_PAGE_BUTTON);
    expect(getStartedButton, findsOneWidget);
    await tester.tap(getStartedButton);
    await tester.pumpAndSettle(Duration(seconds: 2));

    ///Login Page
    expect((find.byType(LoginAndSignInPage)), findsOneWidget);
    expect((find.text(TEST_DATA_LOGIN)), findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final emailFormField=find.byType(TextField).first;
    final passwordFormField=find.byType(TextField).last;
    final loginButton=find.byType(FloatingActionButton).first;
    await tester.enterText(emailFormField, "tester2@gmail.com");
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.enterText(passwordFormField, "10900me!");
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(loginButton);
    await tester.pumpAndSettle(Duration(seconds: 3));

    ///HomePage
    // expect((find.byType(HomePage)), findsOneWidget);
    // await tester.pumpAndSettle(Duration(seconds: 3));
    expect((find.text(TEST_DATA_NOW_SHOWING_MOVIES_NAME)), findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 3));
    expect((find.text(TEST_DATA_Coming_soon_MOVIES_NAME)), findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.text(TEST_DATA_NOW_SHOWING_MOVIES_NAME));
    await tester.pumpAndSettle(Duration(seconds: 6));
    expect(find.text(TEST_DATA_NOW_SHOWING_MOVIES_NAME), findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.text(TEST_DATA_MOVIE_DETAILS_GET_TICKET));
    await tester.pumpAndSettle(Duration(seconds: 3));

    ///Choose Time
    expect(find.text(TEST_DATA_CINEMA_I), findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.text(TEST_DATA_DATE));
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.byKey(Key(TEST_DATA_TIME)).first);
    await tester.pumpAndSettle(Duration(seconds: 5));
    await tester.tap(find.text(TEST_DATA_CHOOSE_TIME_PAGE_NEXT));
    await tester.pumpAndSettle(Duration(seconds: 5));

    ///Seat Page
    expect((find.text(TEST_DATA_NOW_SHOWING_MOVIES_NAME)), findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.byKey(Key("A-3")));
    await tester.tap(find.byKey(Key("A-4")));
    await tester.tap(find.byKey(Key("A-5")));
    await tester.tap(find.byKey(Key("F-6")));
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle(Duration(seconds: 3));
  });
}
