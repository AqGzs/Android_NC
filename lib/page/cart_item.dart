import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(Map<String, dynamic>) onIncreaseQuantity;
  final Function(Map<String, dynamic>) onDecreaseQuantity;
  final Function(Map<String, dynamic>) onRemoveItem;
  final Function(Map<String, dynamic>, int) onQuantityChanged;

  CartItem({
    required this.item,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    required this.onRemoveItem,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item['image'],
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${item['price'].toStringAsFixed(0)}đ',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  'Size: ${(item['size'] as int).toString()}',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () => onDecreaseQuantity(item),
              ),
              Text(
                (item['quantity'] as int).toString(),
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: () => onIncreaseQuantity(item),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => onRemoveItem(item),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
