import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quick_sell/data/data_sources/product_local_data_source.dart';
import 'package:quick_sell/domain/models/product.dart';
import 'package:quick_sell/domain/product_repository.dart';

class JsonProductRepository implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  JsonProductRepository(this.localDataSource);

  @override
  Future<List<Product>> getProducts() async {
    final localProducts = await localDataSource.getLocalProducts();

    if (localProducts.isNotEmpty) {
      return localProducts;
    } else {
      final String data = await rootBundle.loadString('assets/products.json');
      final List<dynamic> jsonList = json.decode(data);

      final List<Product> products = jsonList
          .map((dynamic productJson) => Product.fromJson(productJson))
          .toList();

      await localDataSource.saveLocalProducts(products);

      return products;
    }
  }

  @override
  Future<List<Product>> getLocalProducts() async {
    final localProducts = await localDataSource.getLocalProducts();
    return localProducts;
  }
}

class ApiProductRepository implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ApiProductRepository(this.localDataSource);

  @override
  Future<List<Product>> getProducts() async {
    final localProducts = await localDataSource.getLocalProducts();

    if (localProducts.isNotEmpty) {
      return localProducts;
    } else {
      final apiResponse = await fetchProductsFromApi();

      final apiProducts = apiResponse.map((dynamic productJson) {
        return Product.fromJson(productJson);
      }).toList();

      await localDataSource.saveLocalProducts(apiProducts);

      return apiProducts;
    }
  }

  @override
  Future<List<Product>> getLocalProducts() async {
    final localProducts = await localDataSource.getLocalProducts();
    return localProducts;
  }

  // Simulate a function to download data from the API
  Future<List<dynamic>> fetchProductsFromApi() async {
    await Future.delayed(const Duration(
        seconds: 2)); // Simulation of real data downloading from API

    // Here should be real API
    final fakeApiResponse = [
      {"name": "Product 1 from API", "price": 6.99},
      {"name": "Product 2 from API", "price": 24.50},
      {"name": "Product 3 from API", "price": 14.95}
    ];

    return fakeApiResponse;
  }
}
