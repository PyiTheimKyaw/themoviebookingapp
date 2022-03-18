import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class ProfileDao{
  static final ProfileDao _singleton=ProfileDao._internal();
  factory ProfileDao(){
    return _singleton;
  }
  ProfileDao._internal();

  void saveProfileFromDatabase(UserVO userInfo) async{
    await getProfileBox().put(userInfo.token, userInfo);
  }

  UserVO? getProfile(String tokenData){
      return getProfileBox().get(tokenData);
  }
  ///Reactive
  Stream<void> getAllProfileEventStream(){
    return getProfileBox().watch();
  }

  UserVO? getAllProfileData(String tokenData){
    if(getProfile(tokenData)!= null){
      return getProfile(tokenData);
    }else{
      return null;
    }
  }

  Stream<UserVO?> getAllProfileStream(String tokenData){
    return Stream.value(getProfile(tokenData));
  }

  Box<UserVO> getProfileBox() {
    return Hive.box<UserVO>(BOX_NAME_PROFILE_VO);
  }
}