import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_sell/domain/models/product.dart';
import 'package:quick_sell/presentation/cubits/product_cubit.dart';
import 'package:quick_sell/presentation/pages/product_list_page.dart';

class MockProductCubit extends Mock implements ProductCubit {}

void main() {
  late MockProductCubit mockProductCubit;

  setUp(() {
    mockProductCubit = MockProductCubit();
  });

  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(home: widget);
  }

  testWidgets('ProductsListPage shows loading indicator', (tester) async {
    whenListen(mockProductCubit,
        Stream<ProductState>.fromIterable([ProductLoading()]));

    await tester.pumpWidget(
      buildTestableWidget(
        BlocProvider.value(
          value: mockProductCubit,
          child: const ProductsListPage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('ProductsListPage shows product list', (tester) async {
    final products = [
      Product('Product A', 29.99),
      Product('Product B', 59.99),
    ];
    whenListen(mockProductCubit,
        Stream<ProductState>.fromIterable([ProductLoaded(products)]));

    await tester.pumpWidget(
      buildTestableWidget(
        BlocProvider.value(
          value: mockProductCubit,
          child: const ProductsListPage(),
        ),
      ),
    );

    expect(find.byType(ListTile), findsNWidgets(products.length));
  });
}
