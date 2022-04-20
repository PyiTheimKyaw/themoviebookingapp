import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/profile_dao.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class ProfileDaoImpl extends ProfileDao {
  static final ProfileDaoImpl _singleton = ProfileDaoImpl._internal();

  factory ProfileDaoImpl() {
    return _singleton;
  }

  ProfileDaoImpl._internal();

  @override
  void saveProfileFromDatabase(UserVO userInfo) async {
    await getProfileBox().put(userInfo.token, userInfo);
  }

  @override
  UserVO? getProfile(String tokenData) {
    return getProfileBox().get(tokenData);
  }

  ///Reactive
  @override
  Stream<void> getAllProfileEventStream() {
    return getProfileBox().watch();
  }

  @override
  UserVO? getAllProfileData(String tokenData) {
    if (getProfile(tokenData) != null) {
      return getProfile(tokenData);
    } else {
      return null;
    }
  }

  @override
  Stream<UserVO?> getAllProfileStream(String tokenData) {
    return Stream.value(getProfile(tokenData));
  }

  Box<UserVO> getProfileBox() {
    return Hive.box<UserVO>(BOX_NAME_PROFILE_VO);
  }
}
