import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_movie_booking_app/data/models/checkout_request.dart';
import 'package:the_movie_booking_app/data/vos/logout_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/network/responses/checkout_response.dart';
import 'package:the_movie_booking_app/network/responses/create_card_response.dart';
import 'package:the_movie_booking_app/network/responses/get_cinema_day_timeslot_response.dart';
import 'package:the_movie_booking_app/network/responses/get_cinema_seating_plan_response.dart';
import 'package:the_movie_booking_app/network/responses/get_payment_method_list_response.dart';
import 'package:the_movie_booking_app/network/responses/get_profile_response.dart';
import 'package:the_movie_booking_app/network/responses/get_snack_list_response.dart';
import 'package:the_movie_booking_app/network/responses/movie_list_response.dart';
import 'package:the_movie_booking_app/network/responses/user_response.dart';

part 'the_movie_booking_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class TheMovieBookingApi {
  factory TheMovieBookingApi(Dio dio) = _TheMovieBookingApi;

  @POST(ENDPOINT_REGISTER_WITH_EMAIL)
  Future<UserResponse> registerWithEmail(
    @Field(BODY_NAME) String name,
    @Field(BODY_EMAIL) String email,
    @Field(BODY_PHONE) String phone,
    @Field(BODY_PASSWWORD) String password,
    @Field(BODY_GOOGLE_ACCESS_TOKEN) String googleAccessToken,
    @Field(BODY_FACEBOOK_ACCESS_TOKEN) String facebookAccessToken,
  );

  @POST(ENDPOINT_LOGIN_WITH_EMAIL)
  Future<UserResponse> loginWWithEmail(
    @Field(BODY_EMAIL) String name,
    @Field(BODY_PASSWWORD) String password,
  );

  @POST(ENDPOINT_LOGIN_WITH_FACEBOOK)
  Future<UserResponse> loginInWithFacebook(
    @Field(BODY_ACCESS_TOKEN) String accessToken,
  );
  @POST(ENDPOINT_LOGIN_WITH_GOOGLE)
  Future<UserResponse> loginWithGoogle(
      @Field(BODY_ACCESS_TOKEN) String accessToken,
      );

  @POST(ENDPOINT_LOG_OUT)
  Future<void> logoutUser(
    @Header('Authorization') String authorization,
  );

  @GET(ENDPOINT_GET_CINEMA_DAY_TIMESLOT)
  Future<GetCinemaDayTimeslotResponse> getCinemaDayTimeslot(
    @Header(HEADER_AUTHORIZATION) String authorization,
    @Query(PARAM_MOVIE_ID) String movieId,
    @Query(PARAM_DATE) String date,
  );

  @GET(ENDPOINT_GET_CINEMA_SEATING_PLAN)
  Future<GetCinemaSeatingPlanResponse> getCinemaSeatingPlan(
    @Header(HEADER_AUTHORIZATION) String authorization,
    @Query(PARAM_CINEMA_DAY_TIMESLOT_ID) int cinemaDaTimeslotId,
    @Query(PARAM_BOOKING_DATE) String bookingDate,
  );

  @GET(ENDPOINT_GET_SNACK_LIST)
  Future<GetSnackListResponse> getSnackList(
    @Header(HEADER_AUTHORIZATION) String authorization,
  );

  @GET(ENDPOINT_GET_PAYMENT_METHOD_LIST)
  Future<GetPaymentMethodListResponse> getPaymentMethodList(
    @Header(HEADER_AUTHORIZATION) String authorization,
  );

  @GET(ENDPOINT_GET_PROFILE)
  Future<UserResponse> getProfile(
    @Header(HEADER_AUTHORIZATION) String authorization,
  );

  @POST(ENDPOINT_POST_CREATE_CARD)
  Future<CreateCardResponse> postCreateCard(
    @Header(HEADER_AUTHORIZATION) String authorization,
    @Field(BODY_CARD_NUMBER) String number,
    @Field(BODY_CARD_HOLDER) String holder,
    @Field(BODY_EXPIRATION_DATE) String date,
    @Field(BODY_CVC) String cvc,
  );

  @POST(ENDPOINT_CHECKOUT)
  Future<CheckoutResponse> checkOut(
    @Header(HEADER_AUTHORIZATION) String token,
    @Body() CheckOutRequest checkOutRequest,
  );
}
