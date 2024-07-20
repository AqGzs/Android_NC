import 'package:flutter/material.dart';

class AccountManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6699CC),
        title: Text(
          'Quản lý tài khoản',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Color(0xFF6699CC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchBar(),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Danh sách tài khoản',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    AccountList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Tìm kiếm',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class AccountList extends StatelessWidget {
  final List<Map<String, String>> accounts = [
    {
      'name': 'Nguyễn Thị Bình',
      'role': 'KH',
      'image': 'https://via.placeholder.com/40?text=1'
    },
    {
      'name': 'Nguyễn Anh Tuấn',
      'role': 'KH',
      'image': 'https://via.placeholder.com/40?text=2'
    },
    {
      'name': 'Nguyễn Như Quỳnh',
      'role': 'KH',
      'image': 'https://via.placeholder.com/40?text=3'
    },
    {
      'name': 'Nguyễn Hữu Cảnh',
      'role': 'KH',
      'image': 'https://via.placeholder.com/40?text=4'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  
                  'Họ và tên',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
        

              Expanded(
                flex: 1,
                child: Text(
                  'Vai trò',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 10), // For the three-dot menu
            ],
          ),
        ),
        Divider(),
        ...accounts.map((account) => AccountListItem(account)).toList(),
      ],
    );
  }
}

class AccountListItem extends StatelessWidget {
  final Map<String, String> account;

  AccountListItem(this.account);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(account['image']!),
          ),
          SizedBox(width: 15),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(account['name']!),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                label: Text(account['role']!),
                backgroundColor: Colors.lightBlue[100],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// class User {
//   final String name;
//   final String role;
//   final String profileImageUrl;

//   User(this.name, this.role, this.profileImageUrl);
// }