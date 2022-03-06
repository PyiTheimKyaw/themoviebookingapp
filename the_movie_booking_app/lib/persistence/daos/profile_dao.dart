import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/profile_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class ProfileDao {
  static final ProfileDao _singelton = ProfileDao.internal();

  factory ProfileDao() {
    return _singelton;
  }

  ProfileDao.internal();

  void saveAllProfile(UserVO profileInfo) async {
    // Map<int,UserVO> profile=Map.fromIterable(profileInfo,key: (profilekey)=> profilekey.id,value: (profileValue) => profileValue);
    // await getProfileBox().putAll(profile);
    await getProfileBox().put(profileInfo.id, profileInfo);
  }

  List<UserVO> getAllProfile() {
    return getProfileBox().values.toList();
  }

  ///Reactive Programming
  Stream<void> getAllProfileEventStream() {
    return getProfileBox().watch();
  }

  List<UserVO>? getProfile() {
    if (getAllProfile() != null && (getAllProfile().isNotEmpty ?? false)) {
      return getAllProfile();
    }else{
      return [];
    }
  }

  Stream<List<UserVO>> getProfileStream() {
    return Stream.value(getAllProfile());
  }

  Box<UserVO> getProfileBox() {
    return Hive.box<UserVO>(BOX_NAME_USER_VO);
  }
}
