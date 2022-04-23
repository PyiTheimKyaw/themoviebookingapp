import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/snack_list_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Snack List Bloc Test", () {
    SnackListBloc? snackListBloc;
    setUp(() {
      snackListBloc = SnackListBloc(12, MovieModelImplMock());
    });
    test("Fetch snack List test", () async* {
      expect(snackListBloc?.mSnacksList?.contains(getMockSnackList()), true);
    });
    test("Fetch Payment List test", () async* {
      expect(snackListBloc?.mPaymentMethod?.contains(getMockPaymentMethod()),
          true);
    });

    test("Fetch User choose increase test", () async* {
      snackListBloc?.onTapIncreaseSnack(1);
      await Future.delayed(Duration(seconds: 3));
      expect(snackListBloc?.mSnacksList?.contains(getMockSnackList()), true);
    });
    test("Fetch User choose decrease test", () async* {
      snackListBloc?.onTapDecreaseSnack(1);
      await Future.delayed(Duration(seconds: 3));
      expect(snackListBloc?.mSnacksList?.contains(getMockSnackList()), true);
    });
    test("Fetch User choose payment test", () async* {
      snackListBloc?.onPressedPayment();
      await Future.delayed(Duration(seconds: 3));
      expect(snackListBloc?.mPaymentMethod?.contains(getMockPaymentMethod()),
          true);
    });
  });
}
