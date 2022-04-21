import 'package:the_movie_booking_app/data/models/checkout_request.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_list_for_hive_vo.dart';
import 'package:the_movie_booking_app/data/vos/checkout_vo.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';

import '../mock_data/mock_data.dart';

class MovieModelImplMock extends MovieModel {
  @override
  Future<CheckoutVO?> checkout(CheckOutRequest checkOutRequest) {
    // TODO: implement checkout
    throw UnimplementedError();
  }

  @override
  Stream<List<CardVO>> getCardsFromDatabase() {
    return Stream.value(getMockCardList());
  }

  @override
  void getCinemaDayTimeslot(String authorization, String movieId, String date) {
    // TODO: implement getCinemaDayTimeslot
  }

  @override
  Stream<CinemaListForHiveVO?> getCinemaDayTimeslotFromDatabase(
      String authorization, String movieId, String date) {
    return Stream.value(CinemaListForHiveVO(getMockCinemaDayTimeslot()));
  }

  @override
  Future<List<MovieSeatVO>?> getCinemaSeatingPlan(
      int timeslotId, String bookingDate) {
    // TODO: implement getImdbRating
    throw UnimplementedError();
  }

  @override
  void getComingSoonMovies(int page) {
    // TODO: implement getComingSoonMovies
  }

  @override
  Stream<List<MovieVO>?> getComingSoonMoviesFromDatabase() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  @override
  void getCreditsByMovie(int movieId) {
    // TODO: implement getCreditsByMovie
  }

  @override
  Stream<List<CreditVO>> getCreditsFromDatabase(int movieId) {
    return Stream.value(getMOckCreditsByMovie());
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    // TODO: implement getGenres
    throw UnimplementedError();
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(getMockGenreList());
  }

  @override
  Future<List<MovieVO>?> getImdbRating(String externalId) {
    // TODO: implement getImdbRating
    throw UnimplementedError();
  }

  @override
  Stream<List<UserVO>> getLoginUserIfoDatabase() {
    return Stream.value(getMockProfile());
  }

  @override
  void getMovieDetails(int movieId) {
    // TODO: implement getMovieDetails
  }

  @override
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Stream.value(getMockMoviesForTest().first);
  }

  @override
  Future<List<MovieSeatVO>?> getMovieSeatsFromDatabase() {
    return Future.value(getMockCinemaSeatingPlan().first);
  }

  @override
  void getNowPlayingMovies(int page) {
    // TODO: implement getNowPlayingMovies
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  Stream<List<PaymentMethodVO>?> getPaymentMethodFromDatabase() {
    return Stream.value(getMockPaymentMethod());
  }

  @override
  void getPaymentMethodList(String authorization) {
    // TODO: implement getPaymentMethodList
  }

  @override
  Future<UserVO> getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Stream<UserVO?> getProfileFromDatabase() {
    return Stream.value(getMockProfile().first);
  }

  @override
  Stream<List<UserVO>> getRegisterUserInfoDatabase() {
    // TODO: implement getRegisterUserInfoDatabase
    throw UnimplementedError();
  }

  @override
  void getSnackList() {
    // TODO: implement getSnackList
  }

  @override
  Stream<List<SnackListVO>?> getSnackListFromDatabase() {
    return Stream.value(getMockSnackList());
  }

  @override
  Future<UserVO> loginWithEmail(String email, String password) {
    // TODO: implement loginWithEmail
    throw UnimplementedError();
  }

  @override
  Future<UserVO> loginWithFacebook(String accessToken) {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserVO> loginWithGoogle(String accessToken) {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> logoutUser(String authorization) {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }

  @override
  Future<void> logoutUserFromDatabase() {
    // TODO: implement logoutUserFromDatabase
    throw UnimplementedError();
  }

  @override
  Future<List<CardVO>?> postCreateCard(
      String number, String holder, String date, String cvc) {
    // TODO: implement postCreateCard
    throw UnimplementedError();
  }

  @override
  Future<UserVO> registerWithEmail(String name, String email, String phone,
      String password, String? googleAccessToken, String? facebookAccessToken) {
    // TODO: implement registerWithEmail
    throw UnimplementedError();
  }
}
