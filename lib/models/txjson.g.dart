// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'txjson.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TxJsonAdapter extends TypeAdapter<TxJson> {
  @override
  final int typeId = 1;

  @override
  TxJson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TxJson(
      fields[0] as bool,
      (fields[1] as List).cast<Questions>(),
    );
  }

  @override
  void write(BinaryWriter writer, TxJson obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.multiple)
      ..writeByte(1)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TxJsonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionsAdapter extends TypeAdapter<Questions> {
  @override
  final int typeId = 0;

  @override
  Questions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Questions(
      (fields[0] as List).cast<String?>(),
      (fields[1] as List).cast<String?>(),
      (fields[2] as List).cast<String?>(),
    );
  }

  @override
  void write(BinaryWriter writer, Questions obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.rights)
      ..writeByte(2)
      ..write(obj.answers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
