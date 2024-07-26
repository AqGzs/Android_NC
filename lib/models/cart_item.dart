import 'package:flutter_doanlt/models/stock.dart';

class CartItem {
  final String productId;
  final int quantity;
  final Stock stock;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.stock,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] ?? '',
      quantity: json['quantity'] ?? 0,
      stock: Stock.fromJson(json['stock'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'stock': stock.toJson(),
    };
  }
}