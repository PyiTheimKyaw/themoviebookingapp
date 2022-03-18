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
import 'package:the_movie_booking_app/network/responses/user_response.dart';

abstract class MovieDataAgent {
  Future<List<dynamic>?> registerWithEmail(
      String name,
      String email,
      String phone,
      String password,
      String? googleAccessToken,
      String? facebookAccessToken);

  Future<List<dynamic>?> loginWithEmail(String email, String password);

  Future<List<dynamic>?> loginWithFacebook(String accessToken);

  Future<List<dynamic>?> loginWithGoogle(String accessToken);

  Future<List<MovieVO>?> getNowPlayingMovies(int page);

  Future<List<MovieVO>?> getComingSoonMovies(int page);

  Future<List<GenreVO>?> getGenres();

  Future<MovieVO?> getMovieDetails(int movieId);

  Future<List<CreditVO>?> getCreditsByMovie(int movieId);

  Future<List<MovieVO>?> getImdbRating(String externalId);

  Future<void> logoutUser(String authorization);

  Future<List<CinemaDayTimeSlotVO>?> getCinemaDayTimeslot(
      String authorization, String movieId, String date);

  Future<List<List<MovieSeatVO>>?> getCinemaSeatingPlan(
      String authorization, int timeslotId, String bookingDate);

  Future<List<SnackListVO>?> getSnackList(String authorization);

  Future<List<PaymentMethodVO>?> getPaymentMethodList(String authorization);

  Future<UserVO?> getProfile(String authorization);

  Future<List<CardVO>?> postCreateCard(String authorization, String number,
      String holder, String date, String cvc);

  Future<CheckoutVO?> checkout(
      String authorization, CheckOutRequest checkOutRequest);
}
