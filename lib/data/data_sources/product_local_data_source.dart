import 'package:hive/hive.dart';
import 'package:quick_sell/domain/models/product.dart';

class ProductLocalDataSource {
  final Box<Product> productBox; // Hive database initialization

  ProductLocalDataSource(this.productBox);

  Future<List<Product>> getLocalProducts() async {
    final products = productBox.values.toList();

    return products;
  }

  Future<void> saveLocalProducts(List<Product> products) async {
    // Clear old list
    await productBox.clear();

    // Save new list
    await productBox.addAll(products);
  }
}
