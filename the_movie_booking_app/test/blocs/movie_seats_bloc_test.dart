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

    test("Fetch Seats Test", ()  {
      expect(movieSeatsBloc?.mMovieSeats?.contains(getMockCinemaSeatingPlan().first.first),
          true);
    });

    test("Fetch choose seat test", () async {
      movieSeatsBloc
          ?.onChooseSeat(MovieSeatVO(3, "available", "B-2", "B", 2, true));
      await Future.delayed(Duration(seconds: 6));
      expect(
          movieSeatsBloc?.mMovieSeats?.contains(getMockCinemaSeatingPlan().first.first),
          true);
    });
    test("Fetch total picked seats,total price and tickets test", () async {
      movieSeatsBloc
          ?.onChooseSeat(MovieSeatVO(3, "available", "B-2", "B", 2, true));
      await Future.delayed(Duration(seconds: 6));
      expect(movieSeatsBloc?.pickSeat,["B-2"]);
      expect(movieSeatsBloc?.totalPrice, 2.0);
      expect(movieSeatsBloc?.tickets, 1);
    });
    // test("Fetch Total price test", () async {
    //   movieSeatsBloc
    //       ?.onChooseSeat(MovieSeatVO(3, "available", "B-2", "B", 2, true));
    //   await Future.delayed(Duration(seconds: 5));
    //   expect(movieSeatsBloc?.totalPrice, 2.0);
    // });
    // test("Fetch Total tickets test", ()async{
    //   movieSeatsBloc
    //       ?.onChooseSeat(MovieSeatVO(3, "available", "B-2", "B", 2, true));
    //   await Future.delayed(Duration(seconds: 2));
    //   expect(movieSeatsBloc?.tickets, 1);
    // });
  });
}
