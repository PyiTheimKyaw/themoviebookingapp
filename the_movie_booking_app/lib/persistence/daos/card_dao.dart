import 'package:the_movie_booking_app/data/vos/card_vo.dart';

abstract class CardDao{
  void saveAllCards(List<CardVO> card);
  List<CardVO> getAllCards();
  Stream<void> getAllCardsEventStream();
  List<CardVO> getCards();
  Stream<List<CardVO>> getCardsStream();
}