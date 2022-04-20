import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/snack_list_dao.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class SnackListDaoImpl extends SnackListDao {
  static final SnackListDaoImpl _singleton = SnackListDaoImpl.internal();

  factory SnackListDaoImpl() {
    return _singleton;
  }

  SnackListDaoImpl.internal();

  @override
  void saveSnacks(List<SnackListVO> snack) async {
    Map<int, SnackListVO> snacks = Map.fromIterable(snack,
        key: (snackInfo) => snackInfo.id, value: (snackInfo) => snackInfo);
    await getSnackBox().putAll(snacks);
  }

  @override
  List<SnackListVO> getAllSnacks() {
    return getSnackBox().values.toList();
  }

  ///Reactive Programming
  @override
  Stream<void> getAllSnackEventStream() {
    return getSnackBox().watch();
  }

  @override
  List<SnackListVO> getSnack() {
    if (getAllSnacks() != null && (getAllSnacks().isNotEmpty ?? false)) {
      return getAllSnacks();
    } else {
      return [];
    }
  }

  @override
  Stream<List<SnackListVO>> getSnackStream() {
    return Stream.value(getAllSnacks());
  }

  Box<SnackListVO> getSnackBox() {
    return Hive.box<SnackListVO>(BOX_NAME_SNACK_LIST_VO);
  }
}
