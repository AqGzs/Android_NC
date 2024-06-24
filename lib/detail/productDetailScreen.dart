import 'package:flutter/material.dart';

class productDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF6699CC),
      body: SafeArea(
        child: Column(
          children: [
            Container(
             color: Color(0xFF6699CC),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {},
                    ),
                    Text(
                      'Giày Nam',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_bag),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 200), //có thể hiểu là chiều cao của container chứ thông tin
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30), // Chiều cao/khoảng cách từ điểm bắt đầu của container tới chữ
                          Text(
                            'THỊNH HÀNH',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Nike Air Jordan',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Còn hàng',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Nike Air Jordan là dòng giày bóng rổ của Nike, nổi bật với phong cách và thiết kế độc đáo, nó còn có sự ảnh hưởng lớn trong thể thao và thời trang ...',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'MÀU SẮC',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              ColorOption(Colors.teal),
                              ColorOption(Colors.blue),
                              ColorOption(Colors.amber),
                              ColorOption(Colors.blue, isSelected: true),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'KÍCH CỠ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              SizeOption('38'),
                              SizeOption('39'),
                              SizeOption('40', isSelected: true),
                              SizeOption('41'),
                              SizeOption('42'),
                              SizeOption('43'),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'GIÁ SẢN PHẨM',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '897.000₫',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Thêm vào giỏ',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.network(
                        'https://i.imgur.com/ErVrYBU.png',
                        height: 175,
                        fit: BoxFit.cover,
                        width: 400,
                      ),
                    ),
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

class ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;

  ColorOption(this.color, {this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
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
      margin: EdgeInsets.only(right: 10),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
