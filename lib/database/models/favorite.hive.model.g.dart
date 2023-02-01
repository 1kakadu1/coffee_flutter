// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.hive.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteHiveAdapter extends TypeAdapter<FavoriteHive> {
  @override
  final int typeId = 1;

  @override
  FavoriteHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteHive(
      name: fields[0] as String,
      preview: fields[1] as String?,
      id: fields[2] as String,
      description: fields[4] as String?,
      categorys: (fields[3] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.preview)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.categorys)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
