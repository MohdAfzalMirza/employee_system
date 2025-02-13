// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeDBEntryAdapter extends TypeAdapter<EmployeeDBEntry> {
  @override
  final int typeId = 0;

  @override
  EmployeeDBEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeDBEntry(
      id: fields[0] as int?,
      employeeName: fields[1] as String,
      role: fields[2] as String,
      startDate: fields[3] as DateTime,
      endDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeDBEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.employeeName)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EmployeeDBEntryAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
