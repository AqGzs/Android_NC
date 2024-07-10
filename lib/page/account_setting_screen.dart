import 'package:flutter/material.dart';
import 'package:flutter_doanlt/page/profile_screen.dart';

class AccountSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            padding: const EdgeInsets.only(top: 24),
            child: Center(
              child: Text(
                'Cài đặt',
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
                  child: Icon(Icons.person, size: 20),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF6699CC),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Tài khoản',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 0.0),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Thông tin tài khoản'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()));
                        },
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
                      child: ListTile(
                        leading: Icon(Icons.security),
                        title: Text('Chính sách bảo mật'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {},
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(top: 0.0),
                      child: ListTile(
                        leading: Icon(Icons.file_upload_outlined),
                        title: Text('Nâng cấp tài khoản'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Tuỳ chọn',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 0.0),
                      child: ListTile(
                        leading: Icon(Icons.layers),
                        title: Text('Kiểm tra phiên bản'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {},
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
                      child: ListTile(
                        leading: Icon(Icons.language),
                        title: Text('Ngôn ngữ'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {},
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(top: 0.0),
                      child: ListTile(
                        leading: Icon(Icons.dark_mode_outlined),
                        title: Text('Giao diện'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color(0xFFFFE279),
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: Icon(Icons.logout),
                label: Text(
                  'Đăng xuất',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
