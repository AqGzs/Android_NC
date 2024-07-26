import 'package:flutter/material.dart';
import 'package:flutter_doanlt/page/productDetailScreen.dart';
import 'package:flutter_doanlt/models/shoe.dart';
import 'package:flutter_doanlt/models/stock.dart';
import 'package:flutter_doanlt/page/favorite_button.dart';

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
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: Image.network(
                    widget.shoe.imageUrl,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  right: 12.0,
                  top: 12.0,
                  child: FavoriteButton(shoe: widget.shoe),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
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
                        SizedBox(height: 3.0),
                        Text(
                          widget.shoe.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          widget.shoe.isOutOfStock ? 'Hết hàng' : 'Còn hàng',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          '${widget.shoe.price}đ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    color: Colors.blue,
                    onPressed: () {
                      _showAddToCartDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
