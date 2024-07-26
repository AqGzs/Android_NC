import 'package:flutter/material.dart';
import 'package:flutter_doanlt/api_service/cart_service.dart';
import 'package:flutter_doanlt/api_service/user_service.dart';
import 'package:flutter_doanlt/models/user.dart';
import 'cart_item.dart'; // Import the CartItem widget
import 'checkout_screen.dart'; // Import the CheckoutScreen

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String userId;
  final String token;

  CartScreen({required this.cartItems, required this.userId, required this.token});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];
  final CartService cartService = CartService();


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

  Future<void> _checkout() async {
    final totalAmount = cartItems.fold(
            0.0,
         (sum, item) => sum + ((item['price'] ?? 0.0) * ((item['quantity'] ?? 0) as int)),
          );
      // Xử lý logic thanh toán với thông tin người dùng và các mục trong giỏ hàng
      print('Cart Items: ${cartItems.length}');
      
      await cartService.createCart(widget.userId,cartItems,totalAmount, widget.token );

      // Navigate to the CheckoutScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutScreen(
            token: widget.token,
            userId: widget.userId,
            cartItems: cartItems,
            totalAmount: totalAmount
          ),
        ),
      );
    
  }

  @override
  Widget build(BuildContext context) {
    final double totalAmount = cartItems.fold(
      0.0,
      (sum, item) => sum + ((item['price'] ?? 0.0) * ((item['quantity'] ?? 0) as int)),
    );

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
                    onPressed: _checkout,
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
