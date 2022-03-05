import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_list_for_hive_vo.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class CinemaDayTimeslotDao{
  static final CinemaDayTimeslotDao _singleton=CinemaDayTimeslotDao.internal();
  factory CinemaDayTimeslotDao(){
    return _singleton;
  }
  CinemaDayTimeslotDao.internal();
  List<CinemaDayTimeSlotVO>? cinemaList=[];

  void saveCinemaDayTimeslot(CinemaListForHiveVO cinema,String date) async{
    //Map<String ,CinemaDayTimeSlotVO> cinemaDayTime=Map.fromIterable(cinema,key: (cin) => date,value:(cin)=> cin );
    await getCinemaDayTimeslotBox().put(date,cinema);
  }
  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date){
    return getCinemaDayTimeslotBox().get(date);
  }

  ///Reactive  Programming
  Stream<void> getAllCinemaEventStream(){
    return getCinemaDayTimeslotBox().watch();
  }
  CinemaListForHiveVO? getCinema(String date){
    if(getAllCinemaDayTimeslot(date)!= null){
      return getAllCinemaDayTimeslot(date);
    }
  }
  Stream<CinemaListForHiveVO?> getCinemaStream(String date){
    return Stream.value(getAllCinemaDayTimeslot(date));
  }
  Box<CinemaListForHiveVO> getCinemaDayTimeslotBox(){
    return Hive.box<CinemaListForHiveVO>(BOX_NAME_CINEMA_LIST_FOR_HIVE_VO);
  }
}