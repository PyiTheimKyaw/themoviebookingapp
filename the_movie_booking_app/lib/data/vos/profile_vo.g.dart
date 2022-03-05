// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileVO _$ProfileVOFromJson(Map<String, dynamic> json) => ProfileVO(
      json['id'] as int?,
      json['name'] as String?,
      json['email'] as String?,
      json['phone'],
      (json['total_expense'] as num?)?.toDouble(),
      json['profile_image'] as String?,
      (json['card'] as List<dynamic>?)
          ?.map((e) => CardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileVOToJson(ProfileVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'total_expense': instance.totalExpense,
      'profile_image': instance.profileImage,
      'card': instance.card,
    };
