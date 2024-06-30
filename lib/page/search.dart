import 'package:flutter/material.dart';


class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(0xFF6699CC), // Blue background color
            child: SafeArea(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Color(0xFF6699CC), // Same blue background color
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        // Handle back button press
                      },
                    ),
                    title: Text('Tìm kiếm'),
                    centerTitle: true,
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Handle cancel button press
                        },
                        child: Text(
                          'Huỷ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white, // White background color
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Giày',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildSearchItem('Nike Air Max Shoes'),
                        _buildSearchItem('Nike Jordan Shoes'),
                        _buildSearchItem('Nike Air Force Shoes'),
                        _buildSearchItem('Nike Club Max Shoes'),
                        _buildSearchItem('Snakers Nike Shoes'),
                        _buildSearchItem('Adidas Superstar'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchItem(String text) {
    return ListTile(
      leading: Icon(Icons.access_time),
      title: Text(text),
      onTap: () {
        // Handle search item tap
      },
    );
  }
}
