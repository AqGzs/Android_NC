import 'package:flutter/material.dart';
import 'package:flutter_doanlt/page/trangchu.dart';

class CheckoutScreen extends StatelessWidget {
  // Thêm các biến token và userId vào đây
  final String token;
  final String userId;

  // Sửa constructor để nhận token và userId
  CheckoutScreen({required this.token, required this.userId});

  @override
  Widget build(BuildContext context) {
    final int totalAmount = 1250000;
    final int discount = 40900;
    final int finalAmount = totalAmount - discount;

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
              'Thanh toán',
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    _buildContactInfo(),
                    _buildAddressInfo(),
                    _buildPaymentMethod(),
                  ],
                ),
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
                      _showPaymentSuccessDialog(context);
                    },
                    child: Text('Thanh toán',
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

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Color(0xFFDFEFFF),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/party_alert.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Thanh toán đơn hàng thành công!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                     MaterialPageRoute(builder: (context) => HomePage(token: token, userId: userId)));
                },
                child: Text('Tiếp tục mua sắm',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5B9EE1),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
          Text('Thông tin liên hệ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.email),
              SizedBox(width: 10),
              Expanded(
                child: Text('alissonbecker@gmail.com',
                    style: TextStyle(fontSize: 18)),
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
                child:
                    Text('(+88) 0963-337-916', style: TextStyle(fontSize: 18)),
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
          Text('Địa chỉ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
            'Số 367 Đường Đồng Nai, Phường 13, Quận 10, TP.HCM',
            style: TextStyle(fontSize: 18),
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
          Text('Phương thức thanh toán',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.payment),
              SizedBox(width: 10),
              Expanded(
                child: Text('Thẻ Paypal', style: TextStyle(fontSize: 18)),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.credit_card),
              SizedBox(width: 10),
              Text('**** **** **** 4629', style: TextStyle(fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }
}


