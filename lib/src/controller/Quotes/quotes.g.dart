// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'quotes.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class QuoteAdapter extends TypeAdapter<Quote> {
//   @override
//   final int typeId = 0;

//   @override
//   Quote read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Quote(
//       fields[0] as String,
//       fields[1] as String,
//       fields[3] as String,
//       fields[2] as String,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, Quote obj) {
//     writer
//       ..writeByte(4)
//       ..writeByte(0)
//       ..write(obj.id)
//       ..writeByte(1)
//       ..write(obj.body)
//       ..writeByte(2)
//       ..write(obj.author)
//       ..writeByte(3)
//       ..write(obj.catergory);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is QuoteAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
