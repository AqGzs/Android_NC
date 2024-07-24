import 'package:flutter/material.dart';
import 'package:flutter_doanlt/api_service/shoe_service.dart';
import 'package:flutter_doanlt/models/shoe.dart';

class FavoriteButton extends StatefulWidget {
  final Shoe shoe;

  FavoriteButton({required this.shoe});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;
  final ShoeService _shoeService = ShoeService();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isFavorite = !_isFavorite;
          if (_isFavorite) {

          } else {
            
          }
        });
      },
      child: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        size: 24.0,
        color: _isFavorite ? Colors.red : Colors.black,
      ),
    );
  }
}
