import 'package:flutter/material.dart';
import 'package:flutter_doanlt/page/product_card.dart';

class ProductListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Nike Air Force',
      'price': 367.76,
      'label': 'BEST SELLER',
      'image': 'assets/nike_air_force.png',
      'gender': 'Men\'s shoes',
      'colors': [Colors.blue, Colors.green, Colors.grey],
    },
    {
      'title': 'Nike Air Cadir',
      'price': 259.87,
      'label': 'NEW ARRIVAL',
      'image': 'assets/nike_air_cadir.png',
      'gender': 'Women\'s shoes',
      'colors': [Colors.blue, Colors.red],
    },
    {
      'title': 'Nike Jordan',
      'price': 58.7,
      'label': 'LIMITED EDITION',
      'image': 'assets/nike_jordan.png',
      'gender': 'Men\'s shoes',
      'colors': [Colors.blue, Colors.green, Colors.grey],
    },
    {
      'title': 'Nike Air Max',
      'price': 95.73,
      'label': 'TRENDING NOW',
      'image': 'assets/nike_air_max.png',
      'gender': 'Women\'s shoes',
      'colors': [Colors.blue, Colors.grey],
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
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text('All shoes', style: TextStyle(color: Colors.white)),
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
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.blue,
        child: GridView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
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
