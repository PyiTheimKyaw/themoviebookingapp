import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class CardDao{
  static final CardDao _singleton=CardDao.internal();
  factory CardDao(){
    return _singleton;
  }
  CardDao.internal();

  void saveAllCards(List<CardVO> card) async{
    Map<int,CardVO>  allCards=Map.fromIterable(card,key: (cardId)=> cardId.id,value: (cardValue) => cardValue);
    await getCardBox().putAll(allCards);
  }

  List<CardVO> getAllCards(){
    return getCardBox().values.toList();
  }

  ///Reactive Programming
  Stream<void> getAllCardsEventStream(){
    return getCardBox().watch();
  }
  List<CardVO> getCards(){
    if(getAllCards()!=null &&(getAllCards().isNotEmpty ??  false)){
      return getAllCards();
    }else{
      return [];
    }
  }
  Stream<List<CardVO>> getCardsStream(){
    return Stream.value(getAllCards());
  }
  Box<CardVO> getCardBox(){
    return Hive.box<CardVO>(BOX_NAME_CARD_VO);
  }
}