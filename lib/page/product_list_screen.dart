import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_doanlt/page/filter.dart';
import 'package:flutter_doanlt/page/product_card.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      String data = await DefaultAssetBundle.of(context).loadString('assets/file/shoe_data.json');
      final jsonResult = json.decode(data);
      print('Data loaded: $jsonResult');
      setState(() {
        products = jsonResult['shoes'];
      });
    } catch (e) {
      print('Error loading JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Giày Nike', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
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
                builder: (context) => FilterSheet(),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Color(0xFF6699CC),
        child: products.isNotEmpty
            ? GridView.builder(
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
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

