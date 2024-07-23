class CartItem {
  final String productId;
  final int quantity;
  final String stockId;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.stockId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] ?? '',
      quantity: json['quantity'] ?? 0,
      stockId: json['stock'] ?? '', 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'stock': stockId,
    };
  }
}
