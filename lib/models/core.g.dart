// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Core _$CoreFromJson(Map<String, dynamic> json) => Core(
      json['quizTitle'] as String,
      TxJson.fromJson(json['txJson'] as Map<String, dynamic>),
      (json['rightList'] as List<dynamic>)
          .map((e) =>
              e == null ? null : RightList.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['maxMode'] as bool,
    );

Map<String, dynamic> _$CoreToJson(Core instance) => <String, dynamic>{
      'quizTitle': instance.quizTitle,
      'txJson': instance.txJson,
      'rightList': instance.rightList,
      'maxMode': instance.maxMode,
    };

RightList _$RightListFromJson(Map<String, dynamic> json) => RightList(
      index: json['index'] as int?,
      isTrue: json['isTrue'] as bool?,
      title: json['title'] as String?,
      selected:
          (json['selected'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$RightListToJson(RightList instance) => <String, dynamic>{
      'index': instance.index,
      'isTrue': instance.isTrue,
      'title': instance.title,
      'selected': instance.selected,
    };
