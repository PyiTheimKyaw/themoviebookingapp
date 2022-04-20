import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';

abstract class SnackListDao{
  void saveSnacks(List<SnackListVO> snack);
  List<SnackListVO> getAllSnacks();
  Stream<void> getAllSnackEventStream();
  List<SnackListVO> getSnack();
  Stream<List<SnackListVO>> getSnackStream();
}