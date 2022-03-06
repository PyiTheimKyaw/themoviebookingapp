// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileResponse _$GetProfileResponseFromJson(Map<String, dynamic> json) =>
    GetProfileResponse(
      json['code'] as int?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : ProfileVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetProfileResponseToJson(GetProfileResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
