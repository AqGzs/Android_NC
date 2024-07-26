import 'package:flutter_doanlt/models/order_item.dart';

class Order {
  String id;
  String userId;
  List<OrderItem> items;
  double total;
  DateTime dateOrder;
  String status;
  String paymentMethod;
  String paymentStatus;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.dateOrder,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      userId: json['userId'],
      items: (json['items'] as List).map((item) => OrderItem.fromJson(item)).toList(),
      total: json['total'],
      dateOrder: DateTime.parse(json['dateOrder']),
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'dateOrder': dateOrder.toIso8601String(),
      'status': status,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
    };
  }
}
