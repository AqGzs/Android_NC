import 'package:flutter/material.dart';

void main() {
  runApp(OrderHistoryApp());
}

class OrderHistoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrderHistoryScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class OrderHistoryScreen extends StatelessWidget {
  final List<Order> orders = [
    Order(date: '20/7/2024', name: 'Nike Club Max', size: 'L', price: 640950, status: 'Hoàn Thành', imageUrl: 'assets/images/nike_club_max.jpg'),
    Order(date: '08/7/2024', name: 'Nike Air Max Ex', size: 'XL', price: 648950, status: 'Đã Hủy', imageUrl: 'assets/images/nike_air_max_ex.jpg'),
    Order(date: '12/6/2024', name: 'Nike Air Max Alune', size: 'XXL', price: 753950, status: 'Hoàn Thành', imageUrl: 'assets/images/nike_air_max_alune.jpg'),
    Order(date: '04/03/2024', name: 'Nike Air Cadir', size: 'L', price: 899000, status: 'Hoàn Thành', imageUrl: 'assets/images/nike_air_cadir.jpg'),
    Order(date: '18/1/2024', name: 'Nike Jordan', size: 'XL', price: 1798000, status: 'Đã Hủy', imageUrl: 'assets/images/nike_jordan.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Lịch Sử Đơn Hàng', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button action
          },
        ),
      ),
      body: Container(
        color: Color(0xFFE3F2FD),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return OrderCard(order: order);
          },
        ),
      ),
    );
  }
}

class Order {
  final String date;
  final String name;
  final String size;
  final double price;
  final String status;
  final String imageUrl;

  Order({required this.date, required this.name, required this.size, required this.price, required this.status, required this.imageUrl});
}

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(order.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.date, style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text(order.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Size: ${order.size}', style: TextStyle(fontSize: 14)),
                Text('${order.price.toStringAsFixed(0)}đ', style: TextStyle(fontSize: 14, color: Colors.black)),
                Text(order.status, style: TextStyle(fontSize: 14, color: order.status == 'Hoàn Thành' ? Colors.green : Colors.red)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('SL: 1', style: TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
