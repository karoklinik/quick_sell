import 'package:hive/hive.dart';
import 'package:quick_sell/domain/models/product.dart';

class ProductAdapter extends TypeAdapter<Product> {
  @override
  int get typeId => 0;

  @override
  Product read(BinaryReader reader) {
    // Deserialization
    final name = reader.readString();
    final price = reader.readDouble();

    return Product(
      name,
      price,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.writeString(obj.name);
    writer.writeDouble(obj.price);
  }
}
