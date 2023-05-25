import 'package:json_annotation/json_annotation.dart';

part 'txjson.g.dart';

@JsonSerializable()
class TxJson {
  TxJson(
    this.multiple,
    this.questions,
  );

  bool multiple;
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

@JsonSerializable()
class Questions {
  Questions(
    this.title,
    this.rights,
    this.answers,
  );

  List<String?> title;
  List<String?> rights;
  List<String?> answers;

  factory Questions.fromJson(Map<String, dynamic> json) =>
      _$QuestionsFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionsToJson(this);
}
