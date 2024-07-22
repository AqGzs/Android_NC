import 'package:flutter/material.dart';

class ProductManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF6699CC),
          title: Text(
            'Quản lý sản phẩm',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SearchBar(),
                ),
                SizedBox(height: 10),
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.95, // Adjust this factor as needed
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TabBar(
                        isScrollable: true,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellow,
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black,
                         tabs: [
                      Container(
                        width: 100, // Adjust this width as needed
                        child: Tab(text: "Nike"),
                      ),
                      Container(
                        width: 100, // Adjust this width as needed
                        child: Tab(text: "Puma"),
                      ),
                      Container(
                        width: 150, // Adjust this width as needed
                        child: Tab(text: "Under Armour"),
                      ),
                      Container(
                        width: 100, // Adjust this width as needed
                        child: Tab(text: "Adidas"),
                      ),
                    ],

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xFFB3E5FC),
        body: TabBarView(
          children: [
            ProductList(category: "Nike"),
            ProductList(category: "Puma"),
            ProductList(category: "Under Armour"),
            ProductList(category: "Adidas"),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Tìm kiếm',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final String category;

  final List<Map<String, String>> products = [
    {
      'name': 'Nike Air Jordan',
      'price': '899.000đ',
      'image': 'assets/images/nike_air_jordan.png'
    },
    {
      'name': 'Nike Air Force',
      'price': '899.000đ',
      'image': 'assets/images/nike_air_force.png'
    },
    {
      'name': 'Nike Max',
      'price': '899.000đ',
      'image': 'assets/images/nike_air_max.png'
    },
    {
      'name': 'Nike Blazer Mid',
      'price': '899.000đ',
      'image': 'assets/images/nike_blazer_mid.png'
    },
  ];
  ProductList({required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              leading: Container(
                width: 50, // fixed width
                height: 50, // fixed height
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    product['image']!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(product['name']!),
              subtitle: Text(product['price']!),
            ),
          );
        },
      ),
    );
  }
}
