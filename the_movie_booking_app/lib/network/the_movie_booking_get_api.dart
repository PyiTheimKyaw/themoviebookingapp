import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/network/responses/get_credits_by_movie_response.dart';
import 'package:the_movie_booking_app/network/responses/get_genres_response.dart';
import 'package:the_movie_booking_app/network/responses/imdb_rating_response.dart';
import 'package:the_movie_booking_app/network/responses/movie_list_response.dart';

import 'api_constants.dart';

part 'the_movie_booking_get_api.g.dart';

@RestApi(baseUrl: BASE_MOVIE_URL)
abstract class TheMovieBookingGetApi {
  factory TheMovieBookingGetApi(Dio dio) = _TheMovieBookingGetApi;

  @GET(ENDPOINT_GET_NOW_PLAYING_MOVIES)
  Future<MovieListResponse> getNowPlayingMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_GET_COMMING_SOON_MOVIES)
  Future<MovieListResponse> getComingSoonMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_GET_GENRES)
  Future<GetGenresResponse> getGenres(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
  );

  @GET('$ENDPOINT_GET_MOVIE_DETAIL/{movie_id}')
  Future<MovieVO?> getMovieDetail(
    @Path('movie_id') String movieId,
    @Query(PARAM_API_KEY) String apiKey,
  );

  @GET('/3/movie/{movie_id}/credits')
  Future<GetCreditsByMovieResponse> getCreditsByMovie(
    @Path("movie_id") String movieId,
    @Query(PARAM_API_KEY) String apiKey,
  );

  @GET('$ENDPOINT_GET_IMDB_RATING/{rating}')
  Future<ImdbRatingResponse> getImdbRating(
    @Path('rating') String rating,
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_EXTERNAL_SOURCE) String externalSource,
  );
}
