import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

import '../mock_data/mock_data.dart';
import '../network/movie_data_agent_impl_mock.dart';
import '../persistence/card_dao_impl_mock.dart';
import '../persistence/cinema_day_timeslot_dao_impl_mock.dart';
import '../persistence/credit_dao_impl_mock.dart';
import '../persistence/genre_dao_impl_mock.dart';
import '../persistence/movie_dao_impl_mock.dart';
import '../persistence/movie_seat_dao_impl_mock.dart';
import '../persistence/payment_dao_impl_mock.dart';
import '../persistence/profile_dao_impl_mock.dart';
import '../persistence/snack_list_dao_impl_mock.dart';

void main() {
  group("movie_model_impl", () {
    var movieModel = MovieModelImpl();
    setUp(() {
      movieModel.setDaosAndDataAgents(
        MovieDaoImplMock(),
        GenreDaoImplMock(),
        CreditDaoImplMock(),
        SnackListDaoImplMock(),
        CinemaDayTimeslotDaoImplMock(),
        MovieSeatDaoImplMock(),
        ProfileDaoImplMock(),
        CardDaoImplMock(),
        PaymentDaoImplMock(),
        MovieDataAgentImplMock(),
      );
    });
    test("Get login User Test", () async* {
      expect(movieModel.loginWithEmail("aa@gmasasil.com", "10900me!!1111"),
          completion(equals(getMockProfile())));
    });

    test("Get login 2", () async* {
      expect(
          movieModel.getLoginUserIfoDatabase(),
          emits([
            UserVO(
              2,
              "Admin",
              "cimovie@gmail.com",
              "95943185018",
              357,
              "https://tmba.padc.com.mm/img/lady.png",
              [
                CardVO(1, "Aung Kaung", "8765456789", "08/12", "JCB"),
                CardVO(144, "Aung Kaung", "8765456789", "08/12", "JCB"),
                CardVO(145, "Aung Kaung", "8765456789", "08/12", "JCB"),
              ],
            ),
          ]));
    });
    test("Log out user test", () async* {
      expect(movieModel.logoutUserFromDatabase(),
          completion(equals(getMockProfile())));
    });
    test(
        "Saving Now Playing Movies and Getting Now Playing Movies from Database",
        () async* {
      expect(
          movieModel.getNowPlayingMoviesFromDatabase(),
          emits([
            MovieVO(
                adult: false,
                backDropPath: "/fOy2Jurz9k6RnJnMUMRDAgBwru2.jpg",
                genreIds: [16, 10751, 35, 14],
                id: 508947,
                originalLanguage: "en",
                originalTitle: "Turning Red",
                overView:
                    "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
                popularity: 6268.757,
                posterPath: "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
                releaseDate: "2022-03-10",
                title: "Turning Red",
                video: false,
                voteAverage: 7.5,
                voteCount: 1705,
                isNowPlaying: true,
                isComingSoon: false),
          ]));
    });
    test(
        "Saving Coming Soon Movies and Getting Coming Soon Movies from Database",
        () async* {
      expect(
          movieModel.getComingSoonMoviesFromDatabase(),
          emits([
            MovieVO(
                adult: false,
                backDropPath: "/egoyMDLqCxzjnSrWOz50uLlJWmD.jpg",
                genreIds: [28, 878, 35, 10751],
                id: 675353,
                originalLanguage: "en",
                originalTitle: "Sonic the Hedgehog 2",
                overView: "sonic",
                popularity: 6050.744,
                posterPath: "/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg",
                releaseDate: "2022-03-30",
                title: "Sonic the Hedgehog 2",
                video: false,
                voteAverage: 7.7,
                voteCount: 521,
                isNowPlaying: false,
                isComingSoon: true),
          ]));
    });

    test("Get Genres", () async* {
      expect(movieModel.getGenresFromDatabase(),
          completion(equals(getMockGenreList())));
    });

    test("Get credits from Movies", () async* {
      expect(movieModel.getCreditsFromDatabase(1), () {
        emits([
          CreditVO(
              false,
              2,
              2127,
              "Production",
              "James Wan",
              "James Wan",
              7.919,
              "/bNJccMIKzCtYnndcOKniSKCzo5Y.jpg",
              null,
              null,
              "5ac092aa925141602a03de96",
              null,
              "Production",
              "Producer"),
        ]);
      });
    });
    test("Get Movie Details test", () async* {
      expect(movieModel.getMovieDetailsFromDatabase(1),
          completion(equals(getMockMoviesForTest().first)));
    });

    test("Get Cinema Day Timeslot test", () async* {
      expect(
          movieModel.getCinemaDayTimeslotFromDatabase(
              movieModel.getUserToken(), "634649", "2021-06-28"),
          emits([
            CinemaDayTimeSlotVO(1, "Cinema I", [
              TimeSlotVO(1, "9:30 AM", true),
              TimeSlotVO(2, "12:00 PM", false)
            ]),
          ]));
    });

    test('Get Cinema Seating Plan test', () async* {
      expect(movieModel.getCinemaSeatingPlan(1, "2021-6-28"),
          completion(equals(getMockCinemaSeatingPlan())));
    });

    test("Get Snack List test", () async* {
      expect(
          movieModel.getSnackListFromDatabase(),
          emits([
            SnackListVO(
              1,
              "Popcorn",
              "Et dolores eaque officia aut.",
              2,
              "https://tmba.padc.com.mm/img/snack.jpg",
            ),
          ]));
    });

    test("Get Payment List Test", () async* {
      expect(
          movieModel.getPaymentMethodFromDatabase(),
          emits([
            PaymentMethodVO(1, "Credit card", "Visa, Master Card, JCB", true),
          ]));
    });

    test("Get Card List Test ", () async* {
      expect(
          movieModel.getCardsFromDatabase(),
          emits([
            CardVO(1, "Aung Kaung", "8765456789", "08/12", "JCB"),
          ]));
    });

    test("Get Profile test", () async* {
      expect(
          movieModel.getProfileFromDatabase(),
          emits([
            UserVO(
              2,
              "Admin",
              "cimovie@gmail.com",
              "95943185018",
              357,
              "https://tmba.padc.com.mm/img/lady.png",
              [
                CardVO(1, "Aung Kaung", "8765456789", "08/12", "JCB"),
                CardVO(144, "Aung Kaung", "8765456789", "08/12", "JCB"),
                CardVO(145, "Aung Kaung", "8765456789", "08/12", "JCB"),
              ],
            )
          ]));
    });
  });
}
