import 'package:flutter_doanlt/models/stock.dart';

class OrderItem {
  String id;
  String orderId;
  String shoeId;
  Stock stock;
  int quantity;
  double priceShoe;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.shoeId,
    required this.stock,
    required this.quantity,
    required this.priceShoe,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['_id'],
      orderId: json['orderId'],
      shoeId: json['shoeId'] ?? '',
      stock: Stock.fromJson(json['stock'] ?? {}),
      quantity: json['quantity'] ?? 0,
      priceShoe: json['priceShoe'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'orderId': orderId,
      'shoeId': shoeId,
      'stock': stock.toJson(),
      'quantity': quantity,
      'priceShoe': priceShoe,
    };
  }
}
