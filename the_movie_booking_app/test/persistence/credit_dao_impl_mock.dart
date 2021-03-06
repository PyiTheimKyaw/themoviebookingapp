import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/credit_dao.dart';

import '../mock_data/mock_data.dart';

class CreditDaoImplMock extends CreditDao {
  Map<int?, CreditVO> creditListFromDatabaseMock = {};

  @override
  Stream<void> getAllCastEventStream() {
    return Stream.value(null);
  }

  @override
  List<CreditVO> getAllCasts() {
    return creditListFromDatabaseMock.values.toList();
  }

  @override
  List<CreditVO> getCast() {
    if (getMockCreditsByMovie() != null && getMockCreditsByMovie().isNotEmpty ??
        false) {
      return getMockCreditsByMovie();
    } else {
      return [];
    }
  }

  @override
  Stream<List<CreditVO>> getCastStream() {
    return Stream.value(getMockCreditsByMovie());
  }

  @override
  void saveAllCasts(List<CreditVO> castList) {
    castList.forEach((cast) {
      creditListFromDatabaseMock[cast.id] = cast;
    });
  }

}