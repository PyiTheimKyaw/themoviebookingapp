import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/checkout_request.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/checkout_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/logout_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/network/dataagents/movie_data_agent.dart';
import 'package:the_movie_booking_app/network/responses/user_response.dart';
import 'package:the_movie_booking_app/network/the_movie_booking_api.dart';
import 'package:the_movie_booking_app/network/the_movie_booking_get_api.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  late TheMovieBookingApi mApi;
  late TheMovieBookingGetApi mGetApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    dio.options = BaseOptions(
      headers: {
        HEADER_ACCEPT: APPLICATION_JSON,
        HEADER_CONTENT_TYPE: APPLICATION_JSON,
      },
    );
    mApi = TheMovieBookingApi(dio);
    mGetApi = TheMovieBookingGetApi(dio);
  }

  @override
  Future<List<dynamic>?> registerWithEmail(
      String name,
      String email,
      String phone,
      String password,
      String? googleAccessToken,
      String? facebookAccessToken) {
    return mApi
        .registerWithEmail(name, email, phone, password,
            googleAccessToken ?? "", facebookAccessToken ?? "")
        .asStream()
        .map((data) => [data.data, data.token])
        .first;
  }

  @override
  Future<List<dynamic>?> loginWithEmail(String email, String password) {
    return mApi
        .loginWWithEmail(email, password)
        .asStream()
        .map((data) => [data.data, data.token])
        .first;
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
    return mGetApi
        .getComingSoonMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return mGetApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<CreditVO>?> getCreditsByMovie(int movieId) {
    return mGetApi
        .getCreditsByMovie(movieId.toString(), API_KEY)
        .asStream()
        .map((response) => response.cast)
        .first;
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return mGetApi
        .getGenres(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return mGetApi.getMovieDetail(movieId.toString(), API_KEY);
  }

  @override
  Future<List<MovieVO>?> getImdbRating(String externalId) {
    return mGetApi
        .getImdbRating(externalId, API_KEY, LANGUAGE_EN_US, EXTERNAL_SOURCE)
        .asStream()
        .map((imdb) => imdb.movieResults)
        .first;
  }

  @override
  Future<void> logoutUser(String authorization) {
    return mApi.logoutUser(authorization);
  }

  @override
  Future<List<CinemaDayTimeSlotVO>?> getCinemaDayTimeslot(
      String authorization, String movieId, String date) {
    print(
        'Movie da time slot network layer ===> $authorization $movieId $date');
    return mApi
        .getCinemaDayTimeslot(authorization, movieId, date)
        .asStream()
        .map((data) {
      return data.data;
    }).first;
  }

  @override
  Future<List<List<MovieSeatVO>>?> getCinemaSeatingPlan(
      String authorization, int timeslotId, String bookingDate) {
    return mApi
        .getCinemaSeatingPlan(authorization, timeslotId, bookingDate)
        .asStream()
        .map((seats) {
      return seats.data;
    }).first;
  }

  @override
  Future<List<SnackListVO>?> getSnackList(String authorization) {
    return mApi
        .getSnackList(authorization)
        .asStream()
        .map((snack) => snack.data)
        .first;
  }

  @override
  Future<List<PaymentMethodVO>?> getPaymentMethodList(String authorization) {
    return mApi
        .getPaymentMethodList(authorization)
        .asStream()
        .map((payment) => payment.data)
        .first;
  }

  @override
  Future<UserVO?> getProfile(String authorization) {
    return mApi
        .getProfile(authorization)
        .asStream()
        .map((profile) => profile.data)
        .first;
  }

  @override
  Future<List<CardVO>?> postCreateCard(String authorization, String number,
      String holder, String date, String cvc) {
    return mApi
        .postCreateCard(authorization, number, holder, date, cvc)
        .asStream()
        .map((card) => card.data)
        .first;
  }

  @override
  Future<CheckoutVO?> checkout(
      String authorization, CheckOutRequest checkOutRequest) {
    return mApi
        .checkOut(authorization, checkOutRequest)
        .asStream()
        .map((result) => result.data)
        .first;
  }

  @override
  Future<List<dynamic>?> loginWithFacebook(String accessToken) {
    return mApi
        .loginInWithFacebook(accessToken)
        .asStream()
        .map((token) => [token.data, token.token])
        .first;
  }

  @override
  Future<List?> loginWithGoogle(String accessToken) {
    return mApi
        .loginWithGoogle(accessToken)
        .asStream()
        .map((google) => [google.data, google.token])
        .first;
  }
}
