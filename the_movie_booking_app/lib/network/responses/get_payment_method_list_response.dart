import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
part 'get_payment_method_list_response.g.dart';
@JsonSerializable()
class GetPaymentMethodListResponse{
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<PaymentMethodVO>? data;

  GetPaymentMethodListResponse(this.code, this.message, this.data);


  factory GetPaymentMethodListResponse.fromJson(Map<String,dynamic> json) => _$GetPaymentMethodListResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetPaymentMethodListResponseToJson(this);
}