///Base URL
const String BASE_URL = "https://tmba.padc.com.mm";
const String BASE_MOVIE_URL = "https://api.themoviedb.org";

const String IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w400";

///End Points
const String ENDPOINT_REGISTER_WITH_EMAIL = "/api/v1/register";
const String ENDPOINT_LOGIN_WITH_EMAIL = "/api/v1/email-login";
const String ENDPOINT_LOGIN_WITH_FACEBOOK="/api/v1/facebook-login";
const String ENDPOINT_LOGIN_WITH_GOOGLE="/api/v1/google-login";
const String ENDPOINT_GET_NOW_PLAYING_MOVIES = "/3/movie/now_playing";
const String ENDPOINT_GET_COMMING_SOON_MOVIES = "/3/movie/upcoming";
const String ENDPOINT_GET_MOVIE_DETAIL = "/3/movie/";
const String ENDPOINT_GET_GENRES = "/3/genre/movie/list";
const String ENDPOINT_GET_IMDB_RATING = "/3/find/";
const String ENDPOINT_LOG_OUT = "/api/v1/logout";
const String ENDPOINT_GET_CINEMA_DAY_TIMESLOT = "/api/v1/cinema-day-timeslots";
const String ENDPOINT_GET_CINEMA_SEATING_PLAN="/api/v1/seat-plan";
const String ENDPOINT_GET_SNACK_LIST="/api/v1/snacks";
const String ENDPOINT_GET_PAYMENT_METHOD_LIST="/api/v1/payment-methods";
const String ENDPOINT_GET_PROFILE="/api/v1/profile";
const String ENDPOINT_POST_CREATE_CARD="/api/v1/card";
const String ENDPOINT_CHECKOUT="/api/v1/checkout";
///Parameters
const String PARAM_API_KEY = "api_key";
const String PARAM_LANGUAGE = "language";
const String PARAM_PAGE = "page";
const String PARAM_EXTERNAL_SOURCE = "external_source";
const String PARAM_MOVIE_ID = "movie_id";
const String PARAM_DATE = "date";
const String PARAM_CINEMA_DAY_TIMESLOT_ID="cinema_day_timeslot_id";
const String PARAM_BOOKING_DATE="booking_date";

///Body
const String BODY_NAME = "name";
const String BODY_EMAIL = "email";
const String BODY_PHONE = "phone";
const String BODY_PASSWWORD = "password";
const String BODY_GOOGLE_ACCESS_TOKEN = "google-access-token";
const String BODY_FACEBOOK_ACCESS_TOKEN = "facebook-access-token";
const String BODY_CARD_NUMBER="card_number";
const String BODY_CARD_HOLDER="card_holder";
const String BODY_EXPIRATION_DATE="expiration_date";
const String BODY_CVC="cvc";
const String BODY_ACCESS_TOKEN="access-token";

///Headers
const String HEADER_AUTHORIZATION = "Authorization";
const String HEADER_ACCEPT = "Accept";
const String HEADER_CONTENT_TYPE = "Content-Type";

///Value
const String API_KEY = "27fc1237b77d9361b0399041522ee8fb";
const String LANGUAGE_EN_US = "en-US";
const String EXTERNAL_SOURCE = "imdb_id";
const String AUTHORIZATION = "Bearer ";
const String APPLICATION_JSON = "application/json";
