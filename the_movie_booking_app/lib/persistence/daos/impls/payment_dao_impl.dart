import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/payment_dao.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class PaymentDaoImpl extends PaymentDao {
  static final PaymentDaoImpl _singleton = PaymentDaoImpl.internal();

  factory PaymentDaoImpl() {
    return _singleton;
  }

  PaymentDaoImpl.internal();

  @override
  void savePayment(List<PaymentMethodVO> payment) async {
    Map<int, PaymentMethodVO> allPayments = Map.fromIterable(payment,
        key: (pId) => pId.id, value: (pValue) => pValue);
    await getPaymentBox().putAll(allPayments);
  }

  @override
  List<PaymentMethodVO> getAllPayment() {
    return getPaymentBox().values.toList();
  }

  ///Reactive Programming
  @override
  Stream<void> getAllPaymentEventStream() {
    return getPaymentBox().watch();
  }

  @override
  List<PaymentMethodVO> getPaymentMethod() {
    if (getAllPayment() != null && (getAllPayment().isNotEmpty ?? false)) {
      return getAllPayment();
    } else {
      return [];
    }
  }

  @override
  Stream<List<PaymentMethodVO>> getPaymentStream() {
    return Stream.value(getAllPayment());
  }

  Box<PaymentMethodVO> getPaymentBox() {
    return Hive.box<PaymentMethodVO>(BOX_NAME_PAYMENT_VO);
  }
}
