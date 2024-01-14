// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menfess_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenfessModelImpl _$$MenfessModelImplFromJson(Map<String, dynamic> json) =>
    _$MenfessModelImpl(
      id: json['id'] as int,
      userId: json['userId'] as int,
      body: json['body'] as String?,
      reactions: json['reactions'] as int? ?? 0,
    );

Map<String, dynamic> _$$MenfessModelImplToJson(_$MenfessModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'body': instance.body,
      'reactions': instance.reactions,
    };
