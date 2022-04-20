import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/profile_dao.dart';

import '../mock_data/mock_data.dart';

class ProfileDaoImplMock extends ProfileDao {
  Map<int?, UserVO> profileFromDatabaseMock = {};

  @override
  UserVO? getAllProfileData(String tokenData) {
    return profileFromDatabaseMock.values.toList().first;
  }

  @override
  Stream<void> getAllProfileEventStream() {
    return Stream.value(null);
  }

  @override
  Stream<UserVO?> getAllProfileStream(String tokenData) {
    return Stream.value(getMockProfile().first);
  }

  @override
  UserVO? getProfile(String tokenData) {
    if (tokenData != null) {
      return getMockProfile().first;
    } else {
      return null;
    }
  }

  @override
  void saveProfileFromDatabase(UserVO userInfo) {
    profileFromDatabaseMock[userInfo.id] = userInfo;
  }
}
