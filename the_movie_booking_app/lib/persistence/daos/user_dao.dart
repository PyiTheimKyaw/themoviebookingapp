import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class UserDao {
  static final UserDao _singleton = UserDao._internal();

  factory UserDao() {
    return _singleton;
  }

  UserDao._internal();

  void saveUserInfo(UserVO userInfo) async {
    await getUserBox().put(userInfo.id, userInfo);
  }

  List<UserVO> getAllUsers() {
    return getUserBox().values.toList();
  }

  Future<void> deleteUserBox() {
    return getUserBox().clear();
  }
  ///Reactive Programming
  Stream<void> getAllUsersEventStream(){
    return getUserBox().watch();
  }
  List<UserVO> getUser(){
    if(getAllUsers()!= null && (getAllUsers().isNotEmpty ?? false)){
      return getAllUsers();
    }else{
      return [];
    }
  }
  Stream<List<UserVO>> getUserStream(){
    return Stream.value(getAllUsers());
  }
  Box<UserVO> getUserBox() {
    return Hive.box<UserVO>(BOX_NAME_USER_VO);
  }
}
