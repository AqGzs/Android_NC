import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_doanlt/notification/notificationItem.dart';
 
class NotificationScreen extends StatelessWidget {
  final List<NotificationItem> todayNotifications = [
    NotificationItem(
      imageUrl: 'https://i.imgur.com/ErVrYBU.png',
      description: 'Chúng tôi có sản phẩm mới với các ưu đãi',
      price: '365.950đ',
      time: '6 phút trước',
    ),
    NotificationItem(
      imageUrl: 'https://i.imgur.com/ErVrYBU.png',
      description: 'Chúng tôi có sản phẩm mới với các ưu đãi',
      price: '450.950đ',
      time: '26 phút trước',
    ),
  ];

  final List<NotificationItem> yesterdayNotifications = [
    NotificationItem(
      imageUrl: 'https://i.imgur.com/ErVrYBU.png',
      description: 'Chúng tôi có sản phẩm mới với các ưu đãi',
      price: '365.95đ',
      time: '4 ngày trước',
    ),
    NotificationItem(
      imageUrl: 'https://i.imgur.com/ErVrYBU.png',
      description: 'Chúng tôi có sản phẩm mới với các ưu đãi',
      price: '365.95đ',
      time: '4 ngày trước',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6699CC),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color:Color(0xFF6699CC),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {},
                    ),
                    Text(
                      'Thông báo',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hôm nay',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        ...todayNotifications.map((notification) => NotificationCard(notification: notification)).toList(),
                        SizedBox(height: 20),
                        Text(
                          'Hôm qua',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        ...yesterdayNotifications.map((notification) => NotificationCard(notification: notification)).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            notification.imageUrl,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.description,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  notification.price,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notification.time,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: notification.time.contains('phút') ? Colors.blue : Colors.grey,
                      ),
                      width: 10,
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}