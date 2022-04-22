import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/home_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Home Bloc Test", () {
    HomeBloc? homeBloc;
    setUp(() {
      homeBloc = HomeBloc(MovieModelImplMock());
    });
    test("Fetch Now Playing Movies Test", () async* {
      expect(
          homeBloc?.mNowPlayingMovies?.contains(getMockMoviesForTest().first),
          true);
    });
    test("Fetch Coming Soon Movies Test", () async* {
      expect(homeBloc?.mComingSoonMovies?.contains(getMockMoviesForTest().last),
          true);
    });
    test("Fetch Snack List Test", () async* {
      expect(homeBloc?.mSnackList?.contains(getMockSnackList().first), true);
    });
  });
}
