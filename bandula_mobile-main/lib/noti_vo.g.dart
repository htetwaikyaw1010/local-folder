// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noti_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotiVO _$NotiVOFromJson(Map<String, dynamic> json) => NotiVO(
      id: (json['id'] as num).toInt(),
      userID: (json['user_id'] as num).toInt(),
      title: json['title'] as String,
      message: json['message'] as String,
      status: json['status'] as String,
      created: json['created_at'] as String,
      updated: json['updated_at'] as String,
    );

Map<String, dynamic> _$NotiVOToJson(NotiVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userID,
      'title': instance.title,
      'message': instance.message,
      'status': instance.status,
      'created_at': instance.created,
      'updated_at': instance.updated,
    };
