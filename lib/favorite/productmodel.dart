import 'package:flutter/material.dart';

class Product {
  final String name;
  final String price;
  final String imageUrl;
  final List<Color> colors;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.colors,
  });
}