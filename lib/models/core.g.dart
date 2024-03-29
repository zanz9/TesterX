// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoreAdapter extends TypeAdapter<Core> {
  @override
  final int typeId = 3;

  @override
  Core read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Core(
      fields[0] as String,
      fields[1] as TxJson,
      (fields[2] as List).cast<RightList?>(),
      fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Core obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.quizTitle)
      ..writeByte(1)
      ..write(obj.txJson)
      ..writeByte(2)
      ..write(obj.rightList)
      ..writeByte(3)
      ..write(obj.maxMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RightListAdapter extends TypeAdapter<RightList> {
  @override
  final int typeId = 2;

  @override
  RightList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RightList(
      fields[0] as int?,
      fields[1] as bool?,
      fields[2] as String?,
      (fields[3] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, RightList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.isTrue)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.selected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RightListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ArchiveCoreAdapter extends TypeAdapter<ArchiveCore> {
  @override
  final int typeId = 4;

  @override
  ArchiveCore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArchiveCore(
      fields[0] as Core,
      fields[1] as TxJson,
    );
  }

  @override
  void write(BinaryWriter writer, ArchiveCore obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.core)
      ..writeByte(1)
      ..write(obj.initialTxJson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArchiveCoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      json['index'] as int?,
      json['isTrue'] as bool?,
      json['title'] as String?,
      (json['selected'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$RightListToJson(RightList instance) => <String, dynamic>{
      'index': instance.index,
      'isTrue': instance.isTrue,
      'title': instance.title,
      'selected': instance.selected,
    };
