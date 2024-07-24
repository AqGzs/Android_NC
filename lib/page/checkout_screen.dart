import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doanlt/api_service/user_service.dart';
import 'package:flutter_doanlt/models/user.dart';
// import 'package:pay/pay.dart';

class CheckoutScreen extends StatefulWidget {
  final String token;
  final String userId;
  final int totalAmount; // Add totalAmount

  CheckoutScreen({
    required this.token,
    required this.userId,
    required this.totalAmount,
  });

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final UserService _userService = UserService();
  late Future<User> userFuture;
  String defaultGooglePayConfigString = '';
  // final List<PaymentItem> _paymentItems = [];

  @override
  void initState() {
    super.initState();
    userFuture = _fetchUserDetails();
    _loadGooglePayConfig();
    // _paymentItems.add(PaymentItem(
    //   label: 'Tổng thanh toán',
    //   amount: widget.totalAmount.toString(),
    //   status: PaymentItemStatus.final_price,
    // ));
  }
  
  Future<User> _fetchUserDetails() async {
    return await _userService.getUserDetails(widget.userId, widget.token);
  }

  void _loadGooglePayConfig() async {
    defaultGooglePayConfigString = await rootBundle.loadString('assets/file/gpay.json');
    setState(() {});
  }

  void onGooglePayResult(paymentResult) {
    // Handle Google Pay result
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
      ),
      body: FutureBuilder<User>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Thông tin khách hàng', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Họ và tên: ${user.name ?? ''}'),
                  Text('Email: ${user.email ?? ''}'),
                  Text('Điện thoại: ${user.phone ?? ''}'),
                  Text('Địa chỉ: ${user.address ?? ''}'),
                  SizedBox(height: 20),
                  Text('Thông tin thanh toán', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng thanh toán', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('${widget.totalAmount}đ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 20),
                  // GooglePayButton(
                  //   paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePayConfigString),
                  //   paymentItems: _paymentItems,
                  //   type: GooglePayButtonType.pay,
                  //   onPaymentResult: onGooglePayResult,
                  //   loadingIndicator: const Center(
                  //     child: CircularProgressIndicator(),
                  //   ),
                  // ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Không có thông tin khách hàng'));
          }
        },
      ),
    );
  }
}
