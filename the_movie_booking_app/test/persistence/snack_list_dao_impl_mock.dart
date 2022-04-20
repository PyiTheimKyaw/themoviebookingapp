import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/snack_list_dao.dart';

import '../mock_data/mock_data.dart';

class SnackListDaoImplMock extends SnackListDao {
  Map<int?, SnackListVO> snackListFromDatabaseMock = {};

  @override
  Stream<void> getAllSnackEventStream() {
    return Stream.value(null);
  }

  @override
  List<SnackListVO> getAllSnacks() {
    return snackListFromDatabaseMock.values.toList();
  }

  @override
  List<SnackListVO> getSnack() {
    if (getMockSnackList() != null && getMockSnackList().isNotEmpty ?? false) {
      return getMockSnackList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<SnackListVO>> getSnackStream() {
    return Stream.value(getMockSnackList());
  }

  @override
  void saveSnacks(List<SnackListVO> snack) {
    snack.forEach((snackList) {
      snackListFromDatabaseMock[snackList.id] = snackList;
    });
  }
}
