import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_sell/presentation/cubits/product_cubit.dart';

class ProductsListPage extends StatelessWidget {
  const ProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().loadProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle:
                      Text('Price: \$${product.price.toStringAsFixed(2)}'),
                );
              },
            );
          } else if (state is ProductError) {
            return const Center(child: Text('Error loading products'));
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
