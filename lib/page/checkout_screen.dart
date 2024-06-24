import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int totalAmount = 1250000;
    final int discount = 40900;
    final int finalAmount = totalAmount - discount;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Thanh Toán', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildContactInfo(),
                  _buildAddressInfo(),
                  _buildPaymentMethod(),
                ],
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
                    onPressed: () {},
                    child: Text('Thanh toán', style: TextStyle(fontSize: 16)),
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

  Widget _buildContactInfo() {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Thông tin liên hệ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.email),
              SizedBox(width: 10),
              Expanded(
                child: Text('alissonbecker@gmail.com', style: TextStyle(fontSize: 16)),
              ),
              Icon(Icons.edit),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: 10),
              Expanded(
                child: Text('(+88) 0963-337-916', style: TextStyle(fontSize: 16)),
              ),
              Icon(Icons.edit),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInfo() {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Địa chỉ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
            'Số 367 Đường Đồng Nai, Phường 13, Quận 10, TP.HCM',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            child: Center(child: Text('Bản đồ')),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Phương thức thanh toán', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.payment),
              SizedBox(width: 10),
              Expanded(
                child: Text('Thẻ Paypal', style: TextStyle(fontSize: 16)),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.credit_card),
              SizedBox(width: 10),
              Text('**** **** **** 4629', style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
