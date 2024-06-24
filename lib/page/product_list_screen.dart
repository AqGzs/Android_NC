import 'package:flutter/material.dart';
import 'package:flutter_doanlt/page/filter_screen.dart';
import 'package:flutter_doanlt/page/product_card.dart';

class ProductListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Nike Air Force',
      'price': 367000,
      'label': 'THỊNH HÀNH',
      'image': 'assets/nike_air_force.png',
      'gender': 'Giày Nam',
      'colors': [Colors.blue, Colors.green, Colors.grey],
    },
    {
      'title': 'Nike Air Cadir',
      'price': 259000,
      'label': 'HÀNG MỚI',
      'image': 'assets/nike_air_cadir.png',
      'gender': 'Giày Nữ',
      'colors': [Colors.blue, Colors.red],
    },
    {
      'title': 'Nike Club Max',
      'price': 129.99,
      'label': 'BEST SELLER',
      'image': 'assets/nike_club_max.png',
      'gender': 'Men\'s shoes',
      'colors': [Colors.blue, Colors.green, Colors.grey],
    },
    {
      'title': 'Nike Air Focus',
      'price': 109.99,
      'label': 'BEST SELLER',
      'image': 'assets/nike_air_focus.png',
      'gender': 'Men\'s shoes',
      'colors': [Colors.blue, Colors.orange],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Giày Nike', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => FilterScreen(),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Color(0xFF6699CC),
        child: GridView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ),
   bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
