import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class SnackListDao{
  static final SnackListDao _singleton=SnackListDao.internal();
  factory SnackListDao(){
    return _singleton;
  }
  SnackListDao.internal();
  void saveSnacks(List<SnackListVO> snack) async{
    Map<int,SnackListVO> snacks=Map.fromIterable(snack,key: (snackInfo) => snackInfo.id,value: (snackInfo) => snackInfo);
    await getSnackBox().putAll(snacks);
}
  List<SnackListVO> getAllSnacks(){
    return getSnackBox().values.toList();
  }
  ///Reactive Programming
  Stream<void> getAllSnackEventStream(){
    return getSnackBox().watch();
  }
  List<SnackListVO> getSnack(){
    if(getAllSnacks()!= null &&(getAllSnacks().isNotEmpty ?? false)){
      return getAllSnacks();
    }else{
      return [];
    }
  }
  Stream<List<SnackListVO>> getSnackStream(){
    return Stream.value(getAllSnacks());
  }
  Box<SnackListVO> getSnackBox(){
    return Hive.box<SnackListVO>(BOX_NAME_SNACK_LIST_VO);
  }
}