import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_doanlt/admin/customer_screen.dart';
import 'package:flutter_doanlt/admin/product_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DashboardButton(
              text: 'Quản lý khách hàng',
              color: Colors.grey.shade300,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AccountManagementScreen()));
              },
            ),
            SizedBox(height: 20),
            DashboardButton(
              text: 'Quản lý sản phẩm',
              color: Colors.grey.shade300,
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => ProductManagementScreen()));
              },
            ),
            SizedBox(height: 20),
            DashboardButton(
              text: 'Quản lý đơn hàng',
              color: Colors.grey.shade300,
              onPressed: () {
                Navigator.pushNamed(context, '/orderManagement');
              },
            ),
            SizedBox(height: 20),
            DashboardButton(
              text: 'Đăng xuất',
              color: Colors.yellow,
              textColor: Colors.black,
              icon: Icons.logout,
              onPressed: () {
                // Handle logout action
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final IconData? icon;
  final VoidCallback onPressed;

  DashboardButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.grey,
    this.textColor = Colors.black,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        minimumSize: Size(350, 50), // Ensure all buttons have the same width
      ),
      child: icon == null
          ? Text(
              text,
              style: TextStyle(color: textColor, fontSize: 18),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: textColor,
                  size: 18,
                ),
                SizedBox(width: 10),
                Text(
                  text,
                  style: TextStyle(color: textColor, fontSize: 18),
                ),
              ],
            ),
    );
  }
}