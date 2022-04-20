import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/credit_dao.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class CreditDaoImpl extends CreditDao {
  static final CreditDaoImpl _singleton = CreditDaoImpl._internal();

  factory CreditDaoImpl() {
    return _singleton;
  }

  CreditDaoImpl._internal();

  @override
  void saveAllCasts(List<CreditVO> castList) async {
    Map<int, CreditVO> castMap = Map.fromIterable(castList,
        key: (cast) => cast.id, value: (cast) => cast);
    await getCastBox().putAll(castMap);
  }

  @override
  List<CreditVO> getAllCasts() {
    return getCastBox().values.toList();
  }

  ///Reactive Programming
  @override
  Stream<void> getAllCastEventStream() {
    return getCastBox().watch();
  }

  @override
  List<CreditVO> getCast() {
    if (getAllCasts() != null && (getAllCasts().isNotEmpty ?? false)) {
      return getAllCasts();
    } else {
      return [];
    }
  }

  @override
  Stream<List<CreditVO>> getCastStream() {
    return Stream.value(getAllCasts());
  }

  Box<CreditVO> getCastBox() {
    return Hive.box<CreditVO>(BOX_NAME_CREDIT_VO);
  }
}
