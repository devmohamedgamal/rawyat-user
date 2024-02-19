// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_var.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdsCounterAdapter extends TypeAdapter<AdsCounter> {
  @override
  final int typeId = 1;

  @override
  AdsCounter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdsCounter()
      ..adsCounterMap = (fields[0] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as Map).cast<String, int>()));
  }

  @override
  void write(BinaryWriter writer, AdsCounter obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.adsCounterMap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdsCounterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
