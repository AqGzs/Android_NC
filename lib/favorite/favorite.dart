import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_doanlt/models/shoe.dart';
import 'package:flutter_doanlt/page/product_list/product_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Shoe> favoriteShoes = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteShoes();
  }

  void _loadFavoriteShoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteShoesJson = prefs.getStringList('favoriteShoes') ?? [];
    setState(() {
      favoriteShoes = favoriteShoesJson.map((shoeJson) {
        return Shoe.fromJson(jsonDecode(shoeJson));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6699CC),
       
      // body: Padding(
      //   padding: const EdgeInsets.only(top: 16),
      //   child: favoriteShoes.isNotEmpty
      //       ? GridView.builder(
      //           padding: const EdgeInsets.all(16.0),
      //           itemCount: favoriteShoes.length,
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 2,
      //             crossAxisSpacing: 16,
      //             mainAxisSpacing: 16,
      //             childAspectRatio: 0.8,
      //           ),
      //           // itemBuilder: (context, index) {
      //           //   return ProductCard(
      //           //     shoe: favoriteShoes[index],
      //           //     onAddToCart: (shoe, stock, quantity) {
      //           //       // Implement add to cart if needed
      //           //     },
      //           //   );
      //           // },
      //         )
      //       : const Center(
      //           child: Text(
      //             'Không có sản phẩm yêu thích',
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ),
      // ),
    );
  }
}