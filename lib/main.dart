import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_sell/presentation/cubits/product_cubit.dart';
import 'package:quick_sell/presentation/pages/product_list_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ProductCubit(),
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
