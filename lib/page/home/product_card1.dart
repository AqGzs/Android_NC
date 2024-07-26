import 'package:flutter/material.dart';
import 'package:flutter_doanlt/models/shoe.dart';
import 'package:flutter_doanlt/page/favorite_button.dart';
import 'package:flutter_doanlt/page/productDetailScreen.dart';
import 'package:intl/intl.dart';

class ProductCard1 extends StatelessWidget {
  final Shoe shoe;

  ProductCard1({required this.shoe});

  void _navigateToDetailScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(shoe: shoe),
      ),
    );
  }

  String formatPrice(double price) {
    final NumberFormat formatter = NumberFormat('#,###');
    return formatter.format(price).replaceAll(',', '.') + ' ' + 'VNĐ';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 350,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _navigateToDetailScreen(context),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  'ĐƯỢC ƯA CHUỘNG',
                                  style: TextStyle(
                                    color: Color(0xFF5B9EE1),
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            shoe.name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            formatPrice(shoe.price),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              shoe.imageUrl,
                              fit: BoxFit.contain,
                              height: 130.0,
                              width: 170.0,
                            ),
                          ),
                          Positioned(
                            top: 20.0,
                            left: 10.0,
                            child: FavoriteButton(shoe: shoe),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
