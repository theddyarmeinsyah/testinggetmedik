class ProductModel {
  final int id;
  final int code;
  final String name;
  final double price;
  final double stock;


  ProductModel({ this.id, this.code, this.name, this.price, this.stock});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'price': price,
      'stock': stock
    };
  }

  @override
  String toString() {
    return 'ProductModel{id: $id,code: $code, name: $name, price: $price, stock: $stock}';
  }

}