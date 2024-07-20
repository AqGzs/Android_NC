import 'package:flutter/material.dart';
import 'package:flutter_doanlt/page/cart_item.dart';
import 'package:flutter_doanlt/page/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {
      'title': 'Nike Club Max',
      'price': 640950,
      'size': '40',
      'quantity': 1,
      'image': 'assets/images/nike_air_dunk.png',
    },
    {
      'title': 'Nike Air Max',
      'price': 648950,
      'size': '41',
      'quantity': 4,
      'image': 'assets/images/nike_air_max.png',
    },
    {
      'title': 'Nike Air Force',
      'price': 753950,
      'size': '42',
      'quantity': 2,
      'image': 'assets/images/nike_air_force.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int totalAmount = cartItems.fold(
        0,
        (sum, item) =>
            sum + (item['price'] as int) * (item['quantity'] as int));
    final int discount = 40900;
    final int finalAmount = totalAmount - discount;

    // Giả sử bạn có các giá trị token và userId
    String token = "example_token";
    String userId = "example_userId";

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
                  return CartItem(item: cartItems[index]);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Chiết khấu', style: TextStyle(fontSize: 18)),
                      Text('-${discount.toStringAsFixed(0)}đ',
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
                      Text('${finalAmount.toStringAsFixed(0)}đ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutScreen(token: token, userId: userId)));
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

