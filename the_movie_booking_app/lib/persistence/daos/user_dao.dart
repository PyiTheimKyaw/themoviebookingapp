import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

abstract class UserDao{
  void saveUserInfo(UserVO userInfo);
  List<UserVO> getAllUsers();
  Future<void> deleteUserBox();
  Stream<void> getAllUsersEventStream();
  List<UserVO> getUser();
  Stream<List<UserVO>> getUserStream();
  Box<UserVO> getUserBox();
}