import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quick_sell/domain/models/product.dart';

Future<List<Product>> loadProducts() async {
  final String data = await rootBundle.loadString('assets/products.json');
  final List<dynamic> jsonList = json.decode(data);

  final List<Product> products = jsonList
      .map((dynamic productJson) => Product.fromJson(productJson))
      .toList();

  return products;
}
