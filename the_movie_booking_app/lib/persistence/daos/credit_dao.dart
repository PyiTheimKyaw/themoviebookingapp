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
  ///Reactive Programming
  Stream<void> getAllCastEventStream(){
    return getCastBox().watch();
  }
  List<CreditVO> getCast(){
    if(getAllCasts()!= null && (getAllCasts().isNotEmpty ?? false)){
      return getAllCasts();
    }else{
      return [];
    }
  }
  Stream<List<CreditVO>> getCastStream(){
    return Stream.value(getAllCasts());
  }
  Box<CreditVO> getCastBox(){
    return Hive.box<CreditVO>(BOX_NAME_CREDIT_VO);
  }
}