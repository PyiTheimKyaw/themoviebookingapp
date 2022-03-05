import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class CreditDao{
  static final CreditDao _singleton=CreditDao._internal();
  factory CreditDao(){
    return _singleton;
  }
  CreditDao._internal();
  void saveAllCasts(List<CreditVO> castList) async{
    Map<int,CreditVO> castMap=Map.fromIterable(castList,key: (cast) => cast.id,value: (cast) => cast);
     await getCastBox().putAll(castMap);
  }

  List<CreditVO> getAllCasts(){
    return getCastBox().values.toList();
  }

  Box<CreditVO> getCastBox(){
    return Hive.box<CreditVO>(BOX_NAME_CREDIT_VO);
  }
}