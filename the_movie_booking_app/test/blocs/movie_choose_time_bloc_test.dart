import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/movie_choose_time_bloc.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Movie Choose Time Bloc Test", () {
    MovieChooseTimeBloc? movieChooseTimeBloc;
    setUp(() {
      movieChooseTimeBloc = MovieChooseTimeBloc("1", MovieModelImplMock());
    });
    test("Fetch Cinema List Test", () {
      expect(
          movieChooseTimeBloc?.mCinemaInfo?.first.timeSlots
              ?.contains(TimeSlotVO(1, "9:30 AM", false)),
          true);
    });
    test("Tap date test", () async {
      movieChooseTimeBloc?.getSelectedDate("2127", "2022-04-28");
      await Future.delayed(Duration(microseconds: 500));
      expect(movieChooseTimeBloc?.dateData, "2022-04-28");
    });

    test("Tap time,choose cinema test", () async {
      movieChooseTimeBloc?.onTapChooseTime(1, 1);
      await Future.delayed(Duration(microseconds: 500));
      expect(movieChooseTimeBloc?.userChooseTime, "1:30 PM");
      expect(movieChooseTimeBloc?.userChooseCinema, "Cinema II");
      expect(movieChooseTimeBloc?.userChoosedayTimeslotId, 16);
    });
  });
}
