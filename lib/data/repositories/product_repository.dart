import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quick_sell/domain/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

class JsonProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    final String data = await rootBundle.loadString('assets/products.json');
    final List<dynamic> jsonList = json.decode(data);

    final List<Product> products = jsonList
        .map((dynamic productJson) => Product.fromJson(productJson))
        .toList();

    return products;
  }
}

class ApiProductRepository implements ProductRepository {
  // Example of API
  static const String apiUrl = 'https://example.com/api/products';

  @override
  Future<List<Product>> getProducts() async {
    // Communication with API

    return []; // Place for response from the API
  }
}
