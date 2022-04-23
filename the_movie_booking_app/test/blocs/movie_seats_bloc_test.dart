import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/movie_seats_bloc.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Movie Seats Bloc Test", () {
    MovieSeatsBloc? movieSeatsBloc;
    MovieSeatVO? movieSeat;

    setUp(() {
      movieSeatsBloc = MovieSeatsBloc(1, "2021-6-28", MovieModelImplMock());
    });

    test("Fetch Seats Test", () async* {
      expect(movieSeatsBloc?.mMovieSeats?.contains(getMockCinemaSeatingPlan()),
          true);
    });

    test("Fetch choose seat test", () async* {
      movieSeatsBloc?.onChooseSeat(movieSeat);
      await Future.delayed(Duration(seconds: 2));
      expect(movieSeatsBloc?.mMovieSeats?.contains(getMockCinemaSeatingPlan()),
          true);
    });
  });
}
