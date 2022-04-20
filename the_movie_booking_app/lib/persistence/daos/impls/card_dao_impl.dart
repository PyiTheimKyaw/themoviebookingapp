import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/card_dao.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class CardDaoImpl extends CardDao{
  static final CardDaoImpl _singleton=CardDaoImpl.internal();
  factory CardDaoImpl(){
    return _singleton;
  }
  CardDaoImpl.internal();
  @override
  void saveAllCards(List<CardVO> card) async{
    Map<int,CardVO>  allCards=Map.fromIterable(card,key: (cardId)=> cardId.id,value: (cardValue) => cardValue);
    await getCardBox().putAll(allCards);
  }
  @override
  List<CardVO> getAllCards(){
    return getCardBox().values.toList();
  }

  ///Reactive Programming
  @override
  Stream<void> getAllCardsEventStream(){
    return getCardBox().watch();
  }
  @override
  List<CardVO> getCards(){
    if(getAllCards()!=null &&(getAllCards().isNotEmpty ??  false)){
      return getAllCards();
    }else{
      return [];
    }
  }
  @override
  Stream<List<CardVO>> getCardsStream(){
    return Stream.value(getAllCards());
  }
  Box<CardVO> getCardBox(){
    return Hive.box<CardVO>(BOX_NAME_CARD_VO);
  }
}