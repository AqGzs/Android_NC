import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6699CC),
      appBar: AppBar(
        backgroundColor: Color(0xFF6699CC),
        elevation: 0,
        title: Text('Giày Nam', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  product['image'],
                  height: 200,
                ),
              ),
              SizedBox(height: 16),
              Text(
                product['label'],
                style: TextStyle(
                  color: Color(0xFF5B9EE1),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                product['title'],
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Còn hàng',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Nike Air Jordan là dòng giày bóng rổ của Nike, nổi bật với phong cách và thiết kế độc đáo, nó còn có sự ảnh hưởng lớn trong thể thao và thời trang...',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'MÀU SẮC',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: product['colors'].map<Widget>((color) {
                  return Container(
                    margin: EdgeInsets.only(right: 8.0),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _getColor(color),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
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
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: product['sizes'].map<Widget>((size) {
                  return ChoiceChip(
                    label: Text(
                      size.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    selected: false,
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text(
                'GIÁ SẢN PHẨM',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${product['price']}đ',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Sửa tham số từ primary thành backgroundColor
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
      default:
        return Colors.white;
    }
  }
}
