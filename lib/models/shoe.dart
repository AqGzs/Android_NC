import 'stock.dart';

class Shoe {
  final String id;
  final String name;
  final String brand;
  final double price;
  final List<String> colors;
  final String imageUrl;
  final List<Stock> stocks;

  Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.colors,
    required this.imageUrl,
    required this.stocks,
  });

  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
      id: json['_id'],
      name: json['name'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      colors: List<String>.from(json['colors']),
      imageUrl: json['imageUrl'],
      stocks: json['stocks'] != null && json['stocks'].isNotEmpty
          ? List<Stock>.from(json['stocks'].map((stock) => Stock.fromJson(stock)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'colors': colors,
      'imageUrl': imageUrl,
      'stocks': stocks.map((stock) => stock.toJson()).toList(),
    };
  }

  bool get isOutOfStock {
    return stocks.fold(0, (sum, stock) => sum + stock.quantity) == 0;
  }
}
