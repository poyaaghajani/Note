// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTypeEnumAdapter extends TypeAdapter<TaskTypeEnum> {
  @override
  final int typeId = 3;

  @override
  TaskTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskTypeEnum.banking;
      case 1:
        return TaskTypeEnum.date;
      case 2:
        return TaskTypeEnum.meditation;
      case 3:
        return TaskTypeEnum.meeting;
      case 4:
        return TaskTypeEnum.sport;
      case 5:
        return TaskTypeEnum.working;
      default:
        return TaskTypeEnum.banking;
    }
  }

  @override
  void write(BinaryWriter writer, TaskTypeEnum obj) {
    switch (obj) {
      case TaskTypeEnum.banking:
        writer.writeByte(0);
        break;
      case TaskTypeEnum.date:
        writer.writeByte(1);
        break;
      case TaskTypeEnum.meditation:
        writer.writeByte(2);
        break;
      case TaskTypeEnum.meeting:
        writer.writeByte(3);
        break;
      case TaskTypeEnum.sport:
        writer.writeByte(4);
        break;
      case TaskTypeEnum.working:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
