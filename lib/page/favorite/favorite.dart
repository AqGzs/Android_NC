import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/shoe.dart';


class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Shoe> favoriteShoes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavoriteShoes();
  }

  Future<void> _loadFavoriteShoes() async {
    try {
      var response = await Dio().get('http://192.168.1.172:3000/api/favorites'); // Replace with your API URL
      List<dynamic> data = response.data;
      print('Data loaded: $data');
      setState(() {
        favoriteShoes = data.map((json) => Shoe.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading favorite shoes: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _addToCart(Shoe shoe) {
    // Implement add to cart functionality here
    print('Added to cart: ${shoe.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6699CC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : favoriteShoes.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: favoriteShoes.length,
                      itemBuilder: (context, index) {
                        // return ProductCard(
                        //   // shoe: favoriteShoes[index],
                        //   // onAddToCart: () => _addToCart(favoriteShoes[index]),
                        // );
                      },
                    )
                  : const Center(child: Text('No favorite shoes found')),
        ),
      ),
    );
  }
}
