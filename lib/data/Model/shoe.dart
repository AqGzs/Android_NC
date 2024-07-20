class Shoe {
  final String id;
  final String name;
  final String brand;
  final List<int> sizes;
  final int price;
  final List<Map<String, int>> stocks;
  final List<String> colors;
  final String imageUrl;

  Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.sizes,
    required this.price,
    required this.stocks,
    required this.colors,
    required this.imageUrl,
  });

  factory Shoe.fromJson(Map<String, dynamic> json) {
    // Chuyển đổi kích cỡ từ String sang int
    List<int> sizes = [];
    if (json['sizes'] != null) {
      sizes = (json['sizes'] as List).map((size) => int.tryParse(size.toString()) ?? 0).toList();
    }
    
    // Chuyển đổi stocks đúng cách
    List<Map<String, int>> stocks = [];
    if (json['stocks'] != null) {
      stocks = (json['stocks'] as List).map((stock) {
        return {
          'size': int.tryParse(stock['size'].toString()) ?? 0,
          'quantity': int.tryParse(stock['quantity'].toString()) ?? 0,
        };
      }).toList();
    }

    return Shoe(
      id: json['_id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      sizes: sizes,
      price: int.tryParse(json['price'].toString()) ?? 0,
      stocks: stocks,
      colors: (json['colors'] as List).map((color) => color as String).toList(),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'brand': brand,
      'sizes': sizes,
      'price': price,
      'stocks': stocks,
      'colors': colors,
      'imageUrl': imageUrl,
    };
  }

  bool get isOutOfStock {
    return stocks.fold(0, (sum, stock) => sum + (stock['quantity'] ?? 0)) == 0;
  }
}
