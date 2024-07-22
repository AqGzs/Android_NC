class Shoe {
  final String id;
  final String name;
  final String brand;
  final List<int> sizes;
  final int price;
  final List<Map<String, int>> stocks;
  final List<String> colors;
  final String imageUrl;
  final DateTime createdAt;

  Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.sizes,
    required this.price,
    required this.stocks,
    required this.colors,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Shoe.fromJson(Map<String, dynamic> json) {
    List<int> sizes = [];
    if (json['sizes'] != null) {
      sizes = (json['sizes'] as List).map((size) => int.tryParse(size.toString()) ?? 0).toList();
    }

    List<Map<String, int>> stocks = [];
    if (json['stocks'] != null) {
      stocks = (json['stocks'] as List).map((stock) {
        int size = int.tryParse(stock['size']?.toString() ?? '0') ?? 0;
        int quantity = int.tryParse(stock['quantity']?.toString() ?? '0') ?? 0;
        return {'size': size, 'quantity': quantity};
      }).toList();
    }

    return Shoe(
      id: json['_id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      sizes: sizes,
      price: int.tryParse(json['price']?.toString() ?? '0') ?? 0,
      stocks: stocks,
      colors: (json['colors'] as List).map((color) => color as String).toList(),
      imageUrl: json['imageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
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
      'createdAt': createdAt.toIso8601String(),
    };
  }

  bool get isOutOfStock {
    return stocks.fold(0, (sum, stock) => sum + stock['quantity']!) == 0;
  }
}

