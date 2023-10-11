import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_sell/domain/models/product.dart';

// Cubits states
abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState {}

// Cubit
class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoading());

  void loadProducts() async {
    try {
      emit(ProductLoading());
      final String data = await rootBundle.loadString('assets/products.json');
      final List<dynamic> jsonList = json.decode(data);

      final List<Product> allProducts = jsonList
          .map((dynamic productJson) => Product.fromJson(productJson))
          .toList();

      emit(ProductLoaded(allProducts.take(20).toList()));
    } catch (e) {
      emit(ProductError());
    }
  }
}
