import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/card_dao.dart';

import '../mock_data/mock_data.dart';

class CardDaoImplMock extends CardDao {
  Map<int?, CardVO> cardListFromDatabaseMock = {};

  @override
  List<CardVO> getAllCards() {
    return cardListFromDatabaseMock.values.toList();
  }

  @override
  Stream<void> getAllCardsEventStream() {
    return Stream.value(null);
  }

  @override
  List<CardVO> getCards() {
    if (getMockCardList() != null &&
        getMockCardList().isNotEmpty ??
        false) {
      return getMockCardList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<CardVO>> getCardsStream() {
    return Stream.value(getMockCardList());
  }

  @override
  void saveAllCards(List<CardVO> card) {
    card.forEach((element) {
      cardListFromDatabaseMock[element.id] = element;
    });
  }
}
