 import 'package:flutter/material.dart';
import 'package:flutter_doanlt/detail/productDetailScreen.dart';
import 'package:flutter_doanlt/favorite/favorite.dart';
import 'package:flutter_doanlt/notification/notification.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor:  Color(0xFF6699CC),// Define your primary color here
      ),
      home: favorite(),
    );
  }
}
