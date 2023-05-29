import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:testerx/hive/Type.dart';

part 'txjson.g.dart';

@HiveType(typeId: TxJsonType)
@JsonSerializable()
class TxJson {
  TxJson(
    this.multiple,
    this.questions,
  );

  @HiveField(0)
  bool multiple;
  @HiveField(1)
  List<Questions> questions;

  factory TxJson.fromJson(Map<String, dynamic> json) => _$TxJsonFromJson(json);
  Map<String, dynamic> toJson() => _$TxJsonToJson(this);

  getRandom({int? length}) {
    questions.shuffle();
    if (length != null) {
      questions.length = length;
    }
    for (Questions question in questions) {
      question.answers.shuffle();
    }
  }
}

@HiveType(typeId: QuestionsType)
@JsonSerializable()
class Questions {
  Questions(
    this.title,
    this.rights,
    this.answers,
  );
  @HiveField(0)
  List<String?> title;
  @HiveField(1)
  List<String?> rights;
  @HiveField(2)
  List<String?> answers;

  factory Questions.fromJson(Map<String, dynamic> json) =>
      _$QuestionsFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionsToJson(this);
}
