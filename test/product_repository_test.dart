import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quick_sell/data/data_sources/product_local_data_source.dart';
import 'package:quick_sell/data/data_sources/product_data_repository.dart';
import 'package:quick_sell/domain/models/product.dart';

@GenerateMocks([ProductLocalDataSource])
import 'product_repository_test.mocks.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.initFlutter(appDocumentDirectory.path);

  group('JsonProductRepository', () {
    late ProductLocalDataSource mockLocalDataSource;
    late JsonProductRepository jsonProductRepository;
    late Box<Product> mockProductBox;

    setUp(() async {
      mockProductBox = await Hive.openBox<Product>('test_product_box');
      mockLocalDataSource = ProductLocalDataSource(mockProductBox);
      jsonProductRepository = JsonProductRepository(mockLocalDataSource);

      await mockProductBox.clear();
    });

    test('getProducts() returns local products if available', () async {
      final localProducts = [
        Product('Product A', 29.99),
        Product('Product B', 59.99),
      ];
      when(mockLocalDataSource.getLocalProducts())
          .thenAnswer((_) async => localProducts);

      final products = await jsonProductRepository.getProducts();

      expect(products, localProducts);
      verifyNever(mockLocalDataSource.saveLocalProducts([]));
    });

    test('getLocalProducts() returns local products', () async {
      final localProducts = [
        Product('Product A', 29.99),
        Product('Product B', 59.99),
      ];
      when(mockLocalDataSource.getLocalProducts())
          .thenAnswer((_) async => localProducts);

      final products = await jsonProductRepository.getLocalProducts();

      expect(products, localProducts);
    });

    test('getProducts() returns empty list when local data is empty', () async {
      when(mockLocalDataSource.getLocalProducts()).thenAnswer((_) async => []);

      final products = await jsonProductRepository.getProducts();

      expect(products.isEmpty, isTrue);
      verifyNever(mockLocalDataSource.saveLocalProducts([]));
    });
  });
}
