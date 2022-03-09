import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

class PaymentDao{
  static final PaymentDao _singleton=PaymentDao.internal();
  factory PaymentDao(){
    return _singleton;
  }
  PaymentDao.internal();
  void savePayment(List<PaymentMethodVO> payment)async{
   Map<int,PaymentMethodVO> allPayments=Map.fromIterable(payment,key: (pId)=> pId.id,value: (pValue)=> pValue);
    await getPaymentBox().putAll(allPayments);
  }

  List<PaymentMethodVO> getPayment(){
    return getPaymentBox().values.toList();
  }
  ///Reactive Programming
  Stream<void> getAllPaymentEventStream(){
    return getPaymentBox().watch();
  }
  List<PaymentMethodVO> getPaymentMethod( ){
    if(getPayment()!= null &&(getPayment().isNotEmpty ?? false)){
      return getPayment();
    }else{
      return [];
    }
  }
  Stream<List<PaymentMethodVO>> getPaymentStream( ){
    return Stream.value(getPayment());
  }
  Box<PaymentMethodVO> getPaymentBox(){
      return Hive.box<PaymentMethodVO>(BOX_NAME_PAYMENT_VO);
  }
}