import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:testerx/hive/Type.dart';
import 'txjson.dart';

part 'core.g.dart';

@HiveType(typeId: CoreType)
@JsonSerializable()
class Core {
  Core(this.quizTitle, this.txJson, this.rightList, this.maxMode);
  @HiveField(0)
  String quizTitle;
  @HiveField(1)
  TxJson txJson;
  @HiveField(2)
  List<RightList?> rightList;
  @HiveField(3)
  bool maxMode;

  factory Core.fromJson(Map<String, dynamic> json) => _$CoreFromJson(json);
  Map<String, dynamic> toJson() => _$CoreToJson(this);
}

@HiveType(typeId: RightListType)
@JsonSerializable()
class RightList {
  RightList(this.index, this.isTrue, this.title, this.selected);
  @HiveField(0)
  int? index;
  @HiveField(1)
  bool? isTrue;
  @HiveField(2)
  String? title;
  @HiveField(3)
  List<int>? selected;

  factory RightList.fromJson(Map<String, dynamic> json) =>
      _$RightListFromJson(json);
  Map<String, dynamic> toJson() => _$RightListToJson(this);
}

@HiveType(typeId: ArchiveCoreType)
class ArchiveCore {
  ArchiveCore(this.core, this.initialTxJson);
  @HiveField(0)
  Core core;
  @HiveField(1)
  TxJson initialTxJson;
}
