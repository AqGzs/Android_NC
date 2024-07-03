import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedColor = '';
  String selectedSize = '';

  @override
  void initState() {
    super.initState();
    selectedColor = widget.product['colors'][0];
    selectedSize = widget.product['sizes'][0].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6699CC),
      appBar: AppBar(
        backgroundColor: Color(0xFF6699CC),
        elevation: 0,
        title: Text('Giày Nam', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Image Section
          Container(
            color: Color(0xFF6699CC),
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Image.asset(
                widget.product['image'],
                height: 180,
                fit: BoxFit.cover
              ),
            ),
          ),
          // Main Content Section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD3E2E9),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product['label'],
                      style: TextStyle(
                        color: Color(0xFF5B9EE1),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.product['title'],
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Còn hàng',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Nike Air Jordan là dòng giày bóng rổ của Nike, nổi bật với phong cách và thiết kế độc đáo, nó còn có sự ảnh hưởng lớn trong thể thao và thời trang...',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'MÀU SẮC',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: widget.product['colors'].map<Widget>((color) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                          child: ColorOption(
                            _getColor(color),
                            isSelected: selectedColor == color,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'KÍCH CỠ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      children: widget.product['sizes'].map<Widget>((size) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size.toString();
                            });
                          },
                          child: SizeOption(
                            size.toString(),
                            isSelected: selectedSize == size.toString(),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                      'GIÁ SẢN PHẨM',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${widget.product['price']}đ',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.blue,
                      ),
                    ),]
                   ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Thêm vào giỏ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(String color) {
    switch (color) {
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
      case 'teal':
        return Colors.teal;
      case 'purple':
        return Colors.purple;
      case 'amber':
        return Colors.amber;
      default:
        return Colors.white;
    }
  }
}

class ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;

  ColorOption(this.color, {this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: Colors.blue, width: 3) : null,
      ),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: color,
      ),
    );
  }
}

class SizeOption extends StatelessWidget {
  final String size;
  final bool isSelected;

  SizeOption(this.size, {this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        size,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
