// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodVO _$PaymentMethodVOFromJson(Map<String, dynamic> json) =>
    PaymentMethodVO(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$PaymentMethodVOToJson(PaymentMethodVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isSelected': instance.isSelected,
    };
