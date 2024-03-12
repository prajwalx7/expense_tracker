// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseStorageAdapter extends TypeAdapter<ExpenseStorage> {
  @override
  final int typeId = 0;

  @override
  ExpenseStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseStorage(
      fields[0] as String? ?? '', // Provide default value if null
      fields[1] as double,
      fields[2] as DateTime? ?? DateTime.now(), // Provide default value if null
      fields[3] as String? ?? '', // Provide default value if null
      fields[4] as String? ?? '', // Provide default value if null
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseStorage obj) {
    writer
      ..writeByte(5) // Ensure correct number of fields
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
