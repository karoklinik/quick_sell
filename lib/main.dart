import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_sell/data/data_sources/product_data_repository.dart';
import 'package:quick_sell/data/data_sources/product_local_data_source.dart';
import 'package:quick_sell/domain/models/product.dart';
import 'package:quick_sell/hive_adapters/product_adapter.dart';
import 'package:quick_sell/presentation/cubits/product_cubit.dart';
import 'package:quick_sell/presentation/pages/product_list_page.dart';

void main() async {
  Hive.registerAdapter(ProductAdapter()); // Register the Hive adapter
  await Hive.initFlutter(); // Hive initialization
  final productBox =
      await Hive.openBox<Product>('productBox'); // Create the Hive database

  final localDataSource = ProductLocalDataSource(productBox);
  final productRepository = JsonProductRepository(localDataSource);

  runApp(
    BlocProvider(
      create: (context) => ProductCubit(productRepository),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick Sell',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductsListPage(),
    );
  }
}
