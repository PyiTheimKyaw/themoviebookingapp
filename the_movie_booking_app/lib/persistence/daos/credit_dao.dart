import 'package:the_movie_booking_app/data/vos/credit_vo.dart';

abstract class CreditDao{
  void saveAllCasts(List<CreditVO> castList);
  List<CreditVO> getAllCasts();
  Stream<void> getAllCastEventStream();
  List<CreditVO> getCast();
  Stream<List<CreditVO>> getCastStream();
}