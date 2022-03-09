import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/checkout_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_list_for_hive_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/logout_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/data/vos/profile_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

import 'checkout_request.dart';

abstract class MovieModel {
  ///network
  Future<UserVO> registerWithEmail(String name, String email, String phone,
      String password, String? googleAccessToken, String? facebookAccessToken);

  Future<UserVO> loginWithEmail(String email, String password);

  Future<UserVO> loginWithFacebook(String accessToken);

  Future<UserVO> loginWithGoogle(String accessToken);

  Future<void> logoutUser(String authorization);

  void getNowPlayingMovies(int page);

  void getComingSoonMovies(int page);

  Future<List<GenreVO>?> getGenres();

  void getMovieDetails(int movieId);

 void getCreditsByMovie(int movieId);

  Future<List<MovieVO>?> getImdbRating(String externalId);

  void getCinemaDayTimeslot(String authorization, String movieId, String date);

  Future<List<MovieSeatVO>?> getCinemaSeatingPlan(
      String authorization, int timeslotId, String bookingDate);

  void getSnackList(String authorization);

  void getPaymentMethodList(String authorization);

  Future<UserVO> getProfile();

  Future<List<CardVO>?> postCreateCard(String authorization, String number,
      String holder, String date, String cvc);

  Future<CheckoutVO?> checkout(
      String authorization, CheckOutRequest checkOutRequest);

  ///Database
  Stream<List<UserVO>> getRegisterUserInfoDatabase();

  Stream<List<UserVO>> getLoginUserIfoDatabase();

  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase();

  Stream<List<MovieVO>?> getComingSoonMoviesFromDatabase();

  Future<List<GenreVO>?> getGenresFromDatabase();

  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId);

  // Future<void> logOutUser();
  Future<void> logoutUserFromDatabase();

  Stream<List<SnackListVO>?> getSnackListFromDatabase(String authorization);

  Stream<CinemaListForHiveVO?> getCinemaDayTimeslotFromDatabase(
      String authorization, String movieId, String date);

  Future<List<MovieSeatVO>?> getMovieSeatsFromDatabase();

  Stream<List<CardVO>> getCardsFromDatabase();

  Stream<List<UserVO>?> getProfileFromDatabase();

  Stream<List<PaymentMethodVO>?> getPaymentMethodFromDatabase(String authorization);

  Stream<List<CreditVO>> getCredisFromDatabase(int movieId);
}
