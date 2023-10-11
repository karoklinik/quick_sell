class Product {
  final String name;
  final double price;

  Product(this.name, this.price);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['name'] as String,
      json['price'] as double,
    );
  }
}
