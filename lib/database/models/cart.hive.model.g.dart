// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.hive.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartHiveAdapter extends TypeAdapter<CartHive> {
  @override
  final int typeId = 0;

  @override
  CartHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartHive(
      name: fields[0] as String,
      preview: fields[1] as String?,
      id: fields[2] as String,
      count: fields[3] as int,
      price: fields[4] as dynamic,
      category: fields[5] as String?,
      comments: fields[6] as String?,
      currentSize: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CartHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.preview)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.comments)
      ..writeByte(7)
      ..write(obj.currentSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
