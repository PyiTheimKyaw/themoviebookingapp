// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_method_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPaymentMethodListResponse _$GetPaymentMethodListResponseFromJson(
        Map<String, dynamic> json) =>
    GetPaymentMethodListResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => PaymentMethodVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPaymentMethodListResponseToJson(
        GetPaymentMethodListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
