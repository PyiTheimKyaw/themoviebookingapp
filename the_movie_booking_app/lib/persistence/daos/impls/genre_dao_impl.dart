import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/genre_dao.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';



class GenreDaoImpl extends GenreDao{
  static final GenreDaoImpl _singleton=GenreDaoImpl.internal();
  factory GenreDaoImpl(){
    return _singleton;
  }
  GenreDaoImpl.internal();
  @override
  void saveAllGenres(List<GenreVO> genreList) async{
    Map<int,GenreVO> genreMap=Map.fromIterable(genreList,key: (genre) => genre.id,value: (genre) => genre);
    await getGenreBox().putAll(genreMap);
  }
  @override
  List<GenreVO> getAllGenres(){
    return getGenreBox().values.toList();
  }

  Box<GenreVO> getGenreBox(){
    return Hive.box<GenreVO>(BOX_NAME_GENRE_VO);
  }
}