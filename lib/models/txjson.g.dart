// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'txjson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TxJson _$TxJsonFromJson(Map<String, dynamic> json) => TxJson(
      json['multiple'] as bool,
      (json['questions'] as List<dynamic>)
          .map((e) => Questions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TxJsonToJson(TxJson instance) => <String, dynamic>{
      'multiple': instance.multiple,
      'questions': instance.questions,
    };

Questions _$QuestionsFromJson(Map<String, dynamic> json) => Questions(
      (json['title'] as List<dynamic>).map((e) => e as String?).toList(),
      (json['rights'] as List<dynamic>).map((e) => e as String?).toList(),
      (json['answers'] as List<dynamic>).map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$QuestionsToJson(Questions instance) => <String, dynamic>{
      'title': instance.title,
      'rights': instance.rights,
      'answers': instance.answers,
    };
