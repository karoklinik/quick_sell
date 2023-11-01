import 'package:quick_sell/domain/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<List<Product>> getLocalProducts();
}
