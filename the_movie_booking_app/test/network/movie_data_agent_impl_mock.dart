import 'package:the_movie_booking_app/data/models/checkout_request.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/checkout_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/network/dataagents/movie_data_agent.dart';

import '../mock_data/mock_data.dart';

class MovieDataAgentImplMock extends MovieDataAgent {
  @override
  Future<CheckoutVO?> checkout(
      String authorization, CheckOutRequest checkOutRequest) {
    // TODO: implement checkout
    throw UnimplementedError();
  }

  @override
  Future<List<CinemaDayTimeSlotVO>?> getCinemaDayTimeslot(
      String authorization, String movieId, String date) {
    return Future.value(getMockCinemaDayTimeslot());
  }

  @override
  Future<List<List<MovieSeatVO>>?> getCinemaSeatingPlan(
      String authorization, int timeslotId, String bookingDate) {
    return Future.value(getMockCinemaSeatingPlan());
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
    return Future.value(getMockMoviesForTest()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return Future.value(getMockMoviesForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  Future<List<CreditVO>?> getCreditsByMovie(int movieId) {
    return Future.value(getMOckCreditsByMovie());
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return Future.value(getMockGenreList());
  }

  @override
  Future<List<MovieVO>?> getImdbRating(String externalId) {
    // TODO: implement getImdbRating
    throw UnimplementedError();
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return Future.value(getMockMoviesForTest().first);
  }

  @override
  Future<List<PaymentMethodVO>?> getPaymentMethodList(String authorization) {
    return Future.value(getMockPaymentMethod());
  }

  @override
  Future<UserVO?> getProfile(String authorization) {
    return Future.value(getMockProfile().first);
  }

  @override
  Future<List<SnackListVO>?> getSnackList(String authorization) {
    return Future.value(getMockSnackList());
  }

  @override
  Future<List?> loginWithEmail(String email, String password) {
    return Future.value(getMockProfile());
  }

  @override
  Future<List?> loginWithFacebook(String accessToken) {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<List?> loginWithGoogle(String accessToken) {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> logoutUser(String authorization) {
    return Future.value(getMockProfile());
  }

  @override
  Future<List<CardVO>?> postCreateCard(String authorization, String number,
      String holder, String date, String cvc) {
    // TODO: implement postCreateCard
    throw UnimplementedError();
  }

  @override
  Future<List?> registerWithEmail(String name, String email, String phone,
      String password, String? googleAccessToken, String? facebookAccessToken) {
    // TODO: implement registerWithEmail
    throw UnimplementedError();
  }
}
