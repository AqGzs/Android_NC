import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doanlt/detail/productDetailScreen.dart';
import 'package:flutter_doanlt/models/shoe.dart';
import 'package:flutter_doanlt/models/stock.dart';

class ProductCard extends StatefulWidget {
  final Shoe shoe;
  final Function(Shoe, Stock, int) onAddToCart;

  ProductCard({required this.shoe, required this.onAddToCart});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  void _showAddToCartDialog(BuildContext context) {
    int quantity = 1;
    int selectedSize = widget.shoe.stocks.isNotEmpty ? widget.shoe.stocks.first.size : 0;
    Stock selectedStock = widget.shoe.stocks.isNotEmpty ? widget.shoe.stocks.first : Stock(id: '', size: 0, quantity: 0);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add to Cart'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('Size: '),
                  DropdownButton<int>(
                    value: selectedSize,
                    items: widget.shoe.stocks.map((stock) {
                      return DropdownMenuItem<int>(
                        value: stock.size,
                        child: Text(stock.size.toString()),
                        onTap: () {
                          setState(() {
                            selectedStock = stock;
                          });
                        },
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSize = value!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Quantity: '),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          quantity = int.tryParse(value) ?? 1;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter quantity',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onAddToCart(widget.shoe, selectedStock, quantity);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(shoe: widget.shoe),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: Image.network(
                      widget.shoe.imageUrl,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  right: 12.0,
                  top: 12.0,
                  child: FavoriteButton(shoe: widget.shoe),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.shoe.brand,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      widget.shoe.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      widget.shoe.isOutOfStock ? 'Hết hàng' : 'Còn hàng',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '${widget.shoe.price}đ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Wrap(
                      spacing: 4.0,
                      runSpacing: 4.0,
                      children: widget.shoe.colors.map<Widget>((color) {
                        return Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _getColorFromName(color),
                            shape: BoxShape.circle,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.blue,
                  onPressed: () {
                    _showAddToCartDialog(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'grey':
        return Colors.grey;
      case 'red':
        return Colors.red;
      case 'orange':
        return Colors.orange;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.transparent;
    }
  }
}

class FavoriteButton extends StatefulWidget {
  final Shoe shoe;

  FavoriteButton({required this.shoe});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isFavorite = !_isFavorite;
          if (_isFavorite) {
            _addToFavorites(widget.shoe.id);
          } else {
            _removeFromFavorites(widget.shoe.id);
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

  Future<void> _addToFavorites(String shoeId) async {
    try {
      var response = await Dio().post('http://172.168.1.113:3000/api/favorites',
        data: {'shoeId': shoeId},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print('Added to favorites: ${response.data}');
    } catch (e) {
      print('Error adding to favorites: $e');
    }
  }

  Future<void> _removeFromFavorites(String shoeId) async {
    // Implement remove from favorites logic if needed
  }
}
