import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/payment_dao.dart';

import '../mock_data/mock_data.dart';

class PaymentDaoImplMock extends PaymentDao {
  Map<int?, PaymentMethodVO> paymentMethodFromDatabaseMock = {};

  @override
  Stream<void> getAllPaymentEventStream() {
    return Stream.value(null);
  }

  @override
  List<PaymentMethodVO> getAllPayment() {
    return paymentMethodFromDatabaseMock.values.toList();
  }

  @override
  List<PaymentMethodVO> getPaymentMethod() {
    if (getMockPaymentMethod() != null && getMockPaymentMethod().isNotEmpty ??
        false) {
      return getMockPaymentMethod();
    } else {
      return [];
    }
  }

  @override
  Stream<List<PaymentMethodVO>> getPaymentStream() {
    return Stream.value(getMockPaymentMethod());
  }

  @override
  void savePayment(List<PaymentMethodVO> payment) {
    payment.forEach((element) {
      paymentMethodFromDatabaseMock[element.id] = element;
    });
  }
}
