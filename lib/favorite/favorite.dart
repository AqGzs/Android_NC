import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doanlt/data/Model/shoe.dart';
import 'package:flutter_doanlt/page/product_card.dart';

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
      var response = await Dio().get('http://172.168.1.113:3000/api/favorites'); // Thay bằng URL API của bạn
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6699CC),
      appBar: AppBar(
        backgroundColor: Color(0xFF6699CC),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            splashColor: Color(0xFF6699CC),
            hoverColor: Color(0xFF6699CC),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
              child: Icon(Icons.arrow_back_ios, size: 20),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 22),
          child: Center(
            child: Text(
              'Yêu thích',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
            child: InkWell(
              onTap: () {},
              splashColor: Color(0xFF6699CC),
              hoverColor: Color(0xFF6699CC),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.favorite, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : favoriteShoes.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: favoriteShoes.length,
                      itemBuilder: (context, index) {
                        return ProductCard(shoe: favoriteShoes[index]);
                      },
                    )
                  : Center(child: Text('No favorite shoes found')),
        ),
      ),
    );
  }
}