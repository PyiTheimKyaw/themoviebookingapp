import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_list_for_hive_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/cinema_day_timeslot_dao.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class CinemaDayTimeslotDaoImpl extends CinemaDayTimeslotDao{
  static final CinemaDayTimeslotDaoImpl _singleton=CinemaDayTimeslotDaoImpl.internal();
  factory CinemaDayTimeslotDaoImpl(){
    return _singleton;
  }
  CinemaDayTimeslotDaoImpl.internal();
  List<CinemaDayTimeSlotVO>? cinemaList=[];
  @override
  void saveCinemaDayTimeslot(CinemaListForHiveVO cinema,String date) async{
    //Map<String ,CinemaDayTimeSlotVO> cinemaDayTime=Map.fromIterable(cinema,key: (cin) => date,value:(cin)=> cin );
    await getCinemaDayTimeslotBox().put(date,cinema);
  }
  @override
  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date){
    return getCinemaDayTimeslotBox().get(date);
  }

  ///Reactive  Programming
  @override
  Stream<void> getAllCinemaEventStream(){
    return getCinemaDayTimeslotBox().watch();
  }
  @override
  CinemaListForHiveVO? getCinema(String date){
    if(getAllCinemaDayTimeslot(date)!= null){
      return getAllCinemaDayTimeslot(date);
    }
  }
  @override
  Stream<CinemaListForHiveVO?> getCinemaStream(String date){
    return Stream.value(getAllCinemaDayTimeslot(date));
  }
  Box<CinemaListForHiveVO> getCinemaDayTimeslotBox(){
    return Hive.box<CinemaListForHiveVO>(BOX_NAME_CINEMA_LIST_FOR_HIVE_VO);
  }
}