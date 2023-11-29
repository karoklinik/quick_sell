import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_sell/domain/models/product.dart';
import 'package:quick_sell/domain/product_repository.dart';
import 'package:quick_sell/presentation/cubits/product_cubit.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ProductRepository])
import 'product_cubit_test.mocks.dart';

void main() {
  late ProductRepository mockRepository;
  late ProductCubit productCubit;

  List<Product> mockProducts = [
    Product('Product A', 29.99),
    Product('Product B', 59.99),
  ];

  List<Product> mockLocalProducts = [
    Product('Product C', 19.99),
    Product('Product D', 519.99),
  ];

  setUp(() {
    mockRepository = MockProductRepository();
    productCubit = ProductCubit(mockRepository);
  });

  test('Initial state is loading products', () {
    expect(productCubit.state, const TypeMatcher<ProductLoading>());
  });

  blocTest<ProductCubit, ProductState>(
    'Loads all available products successfully',
    build: () {
      when(mockRepository.getProducts()).thenAnswer((_) async => mockProducts);
      return productCubit;
    },
    act: (cubit) => cubit.loadProducts(),
    expect: () => [
      isA<ProductLoading>(),
      isA<ProductLoaded>(),
    ],
  );

  blocTest<ProductCubit, ProductState>(
    'Fails to load products due to an error when loading all available products',
    build: () {
      when(mockRepository.getProducts())
          .thenThrow(Exception('Failed to load products'));
      return productCubit;
    },
    act: (cubit) => cubit.loadProducts(),
    expect: () => [
      isA<ProductLoading>(),
      isA<ProductError>(),
    ],
  );

  blocTest<ProductCubit, ProductState>(
    'Loads local products successfully',
    build: () {
      when(mockRepository.getLocalProducts())
          .thenAnswer((_) async => mockLocalProducts);
      return productCubit;
    },
    act: (cubit) => cubit.loadLocalProducts(),
    expect: () => [
      isA<ProductLoading>(),
      isA<ProductLoaded>(),
    ],
  );

  blocTest<ProductCubit, ProductState>(
    'Fails to load local products due to an error when loading local products',
    build: () {
      when(mockRepository.getLocalProducts())
          .thenThrow(Exception('Failed to load local products'));
      return productCubit;
    },
    act: (cubit) => cubit.loadLocalProducts(),
    expect: () => [
      isA<ProductLoading>(),
      isA<ProductError>(),
    ],
  );
}
