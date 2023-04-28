// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 0;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      question: fields[0] as String,
      option1: fields[1] as String,
      option2: fields[2] as String,
      option3: fields[3] as String,
      option4: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.option1)
      ..writeByte(2)
      ..write(obj.option2)
      ..writeByte(3)
      ..write(obj.option3)
      ..writeByte(4)
      ..write(obj.option4);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
