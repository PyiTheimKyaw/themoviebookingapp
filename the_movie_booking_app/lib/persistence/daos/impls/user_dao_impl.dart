import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/user_dao.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class UserDaoImpl  {
  static final UserDaoImpl _singleton = UserDaoImpl._internal();

  factory UserDaoImpl() {
    return _singleton;
  }

  UserDaoImpl._internal();

  @override
  void saveUserInfo(UserVO userInfo) async {
    // Map<int,UserVO>  allCards=Map.fromIterable(userInfo,key: (cardId)=> cardId.id,value: (cardValue) => cardValue);
    await getUserBox().put(userInfo.id, userInfo);
    // await getUserBox().putAll(allCards);
  }

  @override
  List<UserVO> getAllUsers() {
    return getUserBox().values.toList();
  }

  @override
  Future<void> deleteUserBox() {
    return getUserBox().clear();
  }

  ///Reactive Programming
  @override
  Stream<void> getAllUsersEventStream() {
    return getUserBox().watch();
  }

  @override
  List<UserVO> getUser() {
    if (getAllUsers() != null && (getAllUsers().isNotEmpty ?? false)) {
      return getAllUsers();
    } else {
      return [];
    }
  }

  @override
  Stream<List<UserVO>> getUserStream() {
    return Stream.value(getAllUsers());
  }

  Box<UserVO> getUserBox() {
    return Hive.box<UserVO>(BOX_NAME_USER_VO);
  }
}
