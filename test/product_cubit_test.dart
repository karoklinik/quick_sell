import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_sell/presentation/cubits/product_cubit.dart';
import 'package:quick_sell/domain/models/product.dart';
import 'package:quick_sell/data/repositories/product_repository.dart';
import 'package:quick_sell/presentation/pages/product_list_page.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('ProductCubit', () {
    late ProductCubit productCubit;
    late MockProductRepository mockRepository;

    setUp(() {
      mockRepository = MockProductRepository();
      productCubit = ProductCubit(mockRepository);
    });

    testWidgets('Initial state is ProductLoading', (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => productCubit,
          child: const MaterialApp(
            home: ProductsListPage(),
          ),
        ),
      );
    });

    test('Emits ProductLoaded when products are loaded', () {
      final products = [
        Product('Product 1', 10.0),
        Product('Product 2', 20.0),
      ];

      when(mockRepository.getProducts()).thenAnswer((_) async => products);

      productCubit.loadProducts();

      expect(productCubit.state, ProductLoaded(products));
    });

    test('Emits ProductError when there is an error', () {
      when(mockRepository.getProducts()).thenThrow(Exception('Error'));

      productCubit.loadProducts();

      expect(productCubit.state, ProductError());
    });
  });
}
