import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_sell/data/repositories/product_repository.dart';
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
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductLoading());

  void loadProducts() async {
    try {
      emit(ProductLoading());
      final List<Product> allProducts = await repository.getProducts();
      emit(ProductLoaded(allProducts.take(20).toList()));
    } catch (e) {
      emit(ProductError());
    }
  }
}
