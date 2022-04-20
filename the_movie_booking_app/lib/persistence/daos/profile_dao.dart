import 'package:the_movie_booking_app/data/vos/user_vo.dart';

abstract class ProfileDao{
  void saveProfileFromDatabase(UserVO userInfo);
  UserVO? getProfile(String tokenData);
  Stream<void> getAllProfileEventStream();
  UserVO? getAllProfileData(String tokenData);
  Stream<UserVO?> getAllProfileStream(String tokenData);
}