import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/voucher_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){
  group("Voucher Bloc Test", (){
    VoucherBloc? voucherBloc;
    setUp((){
      voucherBloc=VoucherBloc(1,MovieModelImplMock());
    });
    test("Movie details test", ()async*{
      expect(voucherBloc?.mMovieDetails, getMockMoviesForTest().first);
    });
  });
}