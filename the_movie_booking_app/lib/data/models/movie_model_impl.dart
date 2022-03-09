import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/checkout_request.dart';
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
import 'package:the_movie_booking_app/network/dataagents/movie_data_agent.dart';
import 'package:the_movie_booking_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:the_movie_booking_app/persistence/daos/card_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/cinema_day_timeslot_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/credit_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/genre_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/movie_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/movie_seat_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/payment_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/profile_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/snack_llist_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/user_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import 'movie_model.dart';

class MovieModelImpl extends MovieModel {
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  MovieDataAgent _dataAgent = RetrofitDataAgentImpl();

  //Dao
  UserDao mUserDao = UserDao();
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  CreditDao mCreditDao = CreditDao();
  SnackListDao mSnackListDao = SnackListDao();
  CinemaDayTimeslotDao mCinemaDayTimeslotDao = CinemaDayTimeslotDao();
  MovieSeatDao mMovieSeatDao = MovieSeatDao();

  // ProfileDao mProfileDao = ProfileDao();
  CardDao mCardDao = CardDao();
  PaymentDao mPaymentDao = PaymentDao();

  String getUserToken() {
    List<UserVO> userToken = mUserDao.getUserBox().values.toList();
    var token = userToken[0].token;
    return "Bearer $token";
  }

  @override
  Future<UserVO> loginWithEmail(String email, String password) {
    debugPrint("Data Login =========> $email and $password");
    return _dataAgent.loginWithEmail(email, password).then((userInfo) {
      var user = userInfo?[0] as UserVO;
      user.token = userInfo?[1] as String;
      mUserDao.saveUserInfo(user);
      return Future.value(user);
    });
  }

  @override
  Future<UserVO> loginWithFacebook(String accessToken) {
    return _dataAgent.loginWithFacebook(accessToken).then((userInfo) {
      var user = userInfo?[0] as UserVO;
      user.token = userInfo?[1] as String;
      mUserDao.saveUserInfo(user);
      return Future.value(user);
    });
  }

  @override
  Future<UserVO> loginWithGoogle(String accessToken) {
    return _dataAgent.loginWithGoogle(accessToken).then((userInfo) {
      var user = userInfo?[0] as UserVO;
      user.token = userInfo?[1] as String;
      mUserDao.saveUserInfo(user);
      return Future.value(user);
    });
  }

  @override
  Future<UserVO> registerWithEmail(String name, String email, String phone,
      String password, String? googleAccessToken, String? facebookAccessToken) {
    debugPrint("Data Login =========> $email and $password");
    return _dataAgent
        .registerWithEmail(name, email, phone, password, googleAccessToken,
            facebookAccessToken)
        .then((userInfo) {
      var user = userInfo?[0] as UserVO;
      user.token = userInfo?[1] as String;
      mUserDao.saveUserInfo(user);

      return Future.value(user);
    });
  }

  @override
  void getNowPlayingMovies(int page) {
    _dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlaying = movies?.map((movie) {
            movie.isNowPlaying = true;
            movie.isComingSoon = false;
            return movie;
          }).toList() ??
          [];
      mMovieDao.saveMovies(nowPlaying);
    });
  }

  @override
  void getComingSoonMovies(int page) {
    _dataAgent.getComingSoonMovies(page).then((movies) async {
      List<MovieVO> nowPlaying = movies?.map((movie) {
            movie.isNowPlaying = false;
            movie.isComingSoon = true;
            return movie;
          }).toList() ??
          [];
      mMovieDao.saveMovies(nowPlaying);
    });
  }

  @override
  void getCreditsByMovie(int movieId) {
     _dataAgent.getCreditsByMovie(movieId).then((value) {
       if(value != null) {
         mCreditDao.saveAllCasts(value);
       }
     });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres().then((genres) async {
      mGenreDao.saveAllGenres(genres ?? []);
      return Future.value(genres);
    });
  }

  @override
  void getMovieDetails(int movieId) {
    _dataAgent.getMovieDetails(movieId).then((movie) async {
      mMovieDao.saveSingleMovie(movie!);
    });
  }

  @override
  Future<List<MovieVO>?> getImdbRating(String externalId) {
    return _dataAgent.getImdbRating(externalId);
  }

  @override
  Future<void> logoutUser(String authorization) {
    debugPrint("UserCode =========> $authorization");
    return Future.value(_dataAgent.logoutUser(getUserToken()));
  }

  @override
  void getCinemaDayTimeslot(String authorization, String movieId, String date) {
    print(
        '"Cinema day time Slot data layer ======> $authorization $movieId $date');
    _dataAgent
        .getCinemaDayTimeslot(getUserToken(), movieId.toString(), date)
        .then((result) {
      CinemaListForHiveVO cListHiveVO = CinemaListForHiveVO(result);
      List<CinemaDayTimeSlotVO> getTimeSlot = result?.map((time) {
            time.timeSlots?.map((timeChoose) {
                  timeChoose.isSelected = false;
                  return timeChoose;
                }).toList() ??
                [];
            return time;
          }).toList() ??
          [];
      mCinemaDayTimeslotDao.saveCinemaDayTimeslot(cListHiveVO, date);
    });
  }

  @override
  Future<List<MovieSeatVO>?> getCinemaSeatingPlan(
      String authorization, int timeslotId, String bookingDate) {
    return _dataAgent
        .getCinemaSeatingPlan(getUserToken(), timeslotId, bookingDate)
        .then((data) {
      List<MovieSeatVO> seatingPlan =
          data?.expand((element) => element).toList().map((seat) {
                seat.isSelected = false;
                return seat;
              }).toList() ??
              [];
      mMovieSeatDao.saveMovieSeats(seatingPlan);
      return Future.value(seatingPlan);
    });
  }

  @override
  void getSnackList(String authorization) {
    _dataAgent.getSnackList(getUserToken()).then((value) async {
      mSnackListDao.saveSnacks(value!);
    });
  }

  @override
  void getPaymentMethodList(String authorization) {
    _dataAgent.getPaymentMethodList(getUserToken()).then((value) {
      mPaymentDao.savePayment(value!);
    });
  }

  @override
  Future<UserVO> getProfile() {
    return _dataAgent.getProfile(getUserToken()).then((value) {

      if (value != null) {
        var user = mUserDao.getUser().first;
        value.token = user.token;
        print('get profile data at impl ${value.token}');
        mUserDao.saveUserInfo(value);
      }
      return Future.value(value);
    });
  }

  @override
  Future<List<CardVO>?> postCreateCard(String authorization, String number,
      String holder, String date, String cvc) {
    print("Create card token $authorization");
    return _dataAgent.postCreateCard(authorization, number, holder, date, cvc);
  }

  @override
  Future<CheckoutVO?> checkout(
      String authorization, CheckOutRequest checkOutRequest) {
    print(
        'Checkout request ======> $authorization ${checkOutRequest.snacks} ${checkOutRequest.cardId} ${checkOutRequest.cinemaId} ${checkOutRequest.movieId}  ${checkOutRequest.cinemaDayTimeSlotId} ${checkOutRequest.bookingDate} ${checkOutRequest.seatNumber}');
    return _dataAgent.checkout(getUserToken(), checkOutRequest);
  }

  ///Database
  @override
  Stream<List<UserVO>> getLoginUserIfoDatabase() {
    return mUserDao
        .getAllUsersEventStream()
        .startWith(mUserDao.getUserStream())
        .map((event) => mUserDao.getUser());
  }

  @override
  Stream<List<UserVO>> getRegisterUserInfoDatabase() {
    return mUserDao
        .getAllUsersEventStream()
        .startWith(mUserDao.getUserStream())
        .map((event) => mUserDao.getUser());
  }

  @override
  Stream<List<MovieVO>?> getComingSoonMoviesFromDatabase() {
    getComingSoonMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getComingSoonMoviesStream())
        .map((event) => mMovieDao.getComingSoonMovies());
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(mGenreDao.getAllGenres());
  }

  @override
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    getMovieDetails(movieId);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getMovieDetailsStream(movieId))
        .map((event) => mMovieDao.getMovieDetails(movieId));
  }

  // @override
  // Future<void> logOutUser() {
  //   return Future.value(mUserDao.deleteUserBox());
  // }

  @override
  Future<void> logoutUserFromDatabase() {
    return Future.value(mUserDao.deleteUserBox());
  }

  @override
  Stream<List<SnackListVO>?> getSnackListFromDatabase(String authorization) {
    getSnackList(getUserToken());
    return mSnackListDao
        .getAllSnackEventStream()
        .startWith(mSnackListDao.getSnackStream())
        .map((event) => mSnackListDao.getSnack());
  }

  @override
  Stream<CinemaListForHiveVO?> getCinemaDayTimeslotFromDatabase(
      String authorization, String movieId, String date) {
    getCinemaDayTimeslot(getUserToken(), movieId, date);
    return mCinemaDayTimeslotDao
        .getAllCinemaEventStream()
        .startWith(mCinemaDayTimeslotDao.getCinemaStream(date))
        .map((event) => mCinemaDayTimeslotDao.getCinema(date));
    // Future.value(
    //   mCinemaDayTimeslotDao.getAllCinemaDayTimeslot(date)?.cinemaList);
  }

  @override
  Future<List<MovieSeatVO>?> getMovieSeatsFromDatabase() {
    return Future.value(mMovieSeatDao.getMovieSeats());
  }

  @override
  Stream<List<CardVO>> getCardsFromDatabase() {
    return mCardDao
        .getAllCardsEventStream()
        .startWith(mCardDao.getCardsStream())
        .map((event) => mCardDao.getCards());
  }

  @override
  Stream<List<UserVO>?> getProfileFromDatabase() {
    return mUserDao
        .getAllUsersEventStream()
        .startWith(mUserDao.getUserStream())
        .map((event) => mUserDao.getUser());
  }

  @override
  Stream<List<PaymentMethodVO>?> getPaymentMethodFromDatabase(
      String authorization) {
    getPaymentMethodList(getUserToken());
    return mPaymentDao
        .getAllPaymentEventStream()
        .startWith(mPaymentDao.getPaymentStream())
        .map((event) => mPaymentDao.getPaymentMethod());
  }

  @override
  Stream<List<CreditVO>> getCredisFromDatabase(int movieId) {
    getCreditsByMovie(movieId);
    return mCreditDao.getAllCastEventStream()
    .startWith(mCreditDao.getCastStream())
    .map((event) => mCreditDao.getCast());
  }
}
