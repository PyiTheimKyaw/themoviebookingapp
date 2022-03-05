import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';

import '../hive_constants.dart';

class GenreDao{
  static final GenreDao _singleton=GenreDao.internal();
  factory GenreDao(){
    return _singleton;
  }
  GenreDao.internal();

  void saveAllGenres(List<GenreVO> genreList) async{
    Map<int,GenreVO> genreMap=Map.fromIterable(genreList,key: (genre) => genre.id,value: (genre) => genre);
    await getGenreBox().putAll(genreMap);
  }

  List<GenreVO> getAllGenres(){
    return getGenreBox().values.toList();
  }

  Box<GenreVO> getGenreBox(){
    return Hive.box<GenreVO>(BOX_NAME_GENRE_VO);
  }
}