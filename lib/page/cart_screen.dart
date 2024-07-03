import 'package:flutter/material.dart';
import 'package:flutter_doanlt/page/cart_item.dart';
import 'package:flutter_doanlt/page/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {
      'title': 'Nike Club Max',
      'price': 640950,
      'size': 'L',
      'quantity': 1,
      'image': 'assets/images/nike_air_dunk.png',
    },
    {
      'title': 'Nike Air Max',
      'price': 648950,
      'size': 'XL',
      'quantity': 4,
      'image': 'assets/images/nike_air_max.png',
    },
    {
      'title': 'Nike Air Force',
      'price': 753950,
      'size': 'XXL',
      'quantity': 2,
      'image': 'assets/images/nike_air_force.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int totalAmount = cartItems.fold(0, (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int));
    final int discount = 40900;
    final int finalAmount = totalAmount - discount;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Giỏ Hàng', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartItem(item: cartItems[index]);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng tiền hàng', style: TextStyle(fontSize: 16)),
                      Text('${totalAmount.toStringAsFixed(0)}đ', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Chiết khấu', style: TextStyle(fontSize: 16)),
                      Text('-${discount.toStringAsFixed(0)}đ', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng thanh toán', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('${finalAmount.toStringAsFixed(0)}đ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckoutScreen()));
                    },
                    child: Text('Đặt hàng', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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