import 'package:flutter/material.dart';
import 'package:flutter_doanlt/page/cart_item.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    cartItems = widget.cartItems;
  }

  void _increaseQuantity(Map<String, dynamic> item) {
    setState(() {
      item['quantity'] = (item['quantity'] ?? 0) + 1;
    });
  }

  void _decreaseQuantity(Map<String, dynamic> item) {
    setState(() {
      if ((item['quantity'] ?? 0) > 1) {
        item['quantity'] = (item['quantity'] ?? 0) - 1;
      }
    });
  }

  void _removeItem(Map<String, dynamic> item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  void _onQuantityChanged(Map<String, dynamic> item, int newQuantity) {
    setState(() {
      item['quantity'] = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalAmount = cartItems.fold(
        0,
        (sum, item) =>
            sum + ((item['price'] ?? 0) as int) * ((item['quantity'] ?? 0) as int));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6699CC),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            splashColor: Color(0xFF6699CC),
            hoverColor: Color(0xFF6699CC),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
              child: Icon(Icons.arrow_back_ios, size: 20),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Center(
            child: Text(
              'Giỏ hàng',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            width: 52,
            height: 40,
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartItem(
                    item: cartItems[index],
                    onIncreaseQuantity: _increaseQuantity,
                    onDecreaseQuantity: _decreaseQuantity,
                    onRemoveItem: _removeItem,
                    onQuantityChanged: _onQuantityChanged,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng tiền hàng', style: TextStyle(fontSize: 18)),
                      Text('${totalAmount.toStringAsFixed(0)}đ',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng thanh toán',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('${totalAmount.toStringAsFixed(0)}đ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Thực hiện hành động khi đặt hàng
                    },
                    child: Text('Đặt hàng',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFE279),
                      foregroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
