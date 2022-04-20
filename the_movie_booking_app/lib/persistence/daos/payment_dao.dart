import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';

abstract class PaymentDao{
  void savePayment(List<PaymentMethodVO> payment);
  List<PaymentMethodVO> getAllPayment();
  Stream<void> getAllPaymentEventStream();
  List<PaymentMethodVO> getPaymentMethod();
  Stream<List<PaymentMethodVO>> getPaymentStream();
}