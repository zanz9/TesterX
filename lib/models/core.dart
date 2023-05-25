import 'package:json_annotation/json_annotation.dart';
import 'txjson.dart';

part 'core.g.dart';

@JsonSerializable()
class Core {
  Core(this.quizTitle, this.txJson, this.rightList, this.maxMode);
  String quizTitle;
  TxJson txJson;
  List<RightList?> rightList;
  bool maxMode;

  factory Core.fromJson(Map<String, dynamic> json) => _$CoreFromJson(json);
  Map<String, dynamic> toJson() => _$CoreToJson(this);
}

@JsonSerializable()
class RightList {
  RightList(
      {required this.index,
      required this.isTrue,
      required this.title,
      required this.selected});
  int? index;
  bool? isTrue;
  String? title;
  List<int>? selected;

  factory RightList.fromJson(Map<String, dynamic> json) =>
      _$RightListFromJson(json);
  Map<String, dynamic> toJson() => _$RightListToJson(this);
}
