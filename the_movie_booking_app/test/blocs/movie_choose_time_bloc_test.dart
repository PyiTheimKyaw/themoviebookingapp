import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/movie_choose_time_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){
  group("Movie Choose Time Bloc Test", (){
    MovieChooseTimeBloc? movieChooseTimeBloc;
    setUp((){
      movieChooseTimeBloc=MovieChooseTimeBloc("1",MovieModelImplMock());
    });
    test("Fetch Cinema List Test", ()async*{
      expect(movieChooseTimeBloc?.mCinemaInfo?.contains(getMockCinemaDayTimeslot()), true);
    });
  });
}