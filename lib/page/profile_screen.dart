import 'package:flutter/material.dart';
import 'package:flutter_doanlt/page/edit_password_screen.dart';
import 'package:flutter_doanlt/page/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6699CC), // Màu nền xanh nhạt
      appBar: AppBar(
        backgroundColor: Color(0xFF6699CC),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0), // Add padding to the left
          child: InkWell(
            onTap: () {}, // Add tap callback
            splashColor: Color(0xFF6699CC), // Remove splash effect
            hoverColor: Color(0xFF6699CC),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background
                shape: BoxShape.circle, // Circular shape
              ),
              padding: const EdgeInsets.all(8.0), // Add padding to the icon
              child: Icon(Icons.arrow_back_ios, size: 20), // Reduce icon size
            ),
          ),
        ),
        title: Center(
          child: Text(
            'Thông tin tài khoản',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: 16.0), // Add padding to the right
            child: InkWell(
              onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
              }, // Add tap callback
              splashColor: Color(0xFF6699CC),
              hoverColor: Color(0xFF6699CC), // Remove splash effect
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  shape: BoxShape.circle, // Circular shape
                ),
                padding: const EdgeInsets.all(8.0), // Add padding to the icon
                child:
                    Icon(Icons.edit, color: Colors.black), 
                    
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileDetailRow(title: 'Họ và tên', value: 'Lê Minh Tuấn'),
                ProfileDetailRow(title: 'Ngày sinh', value: '25/05/2003'),
                ProfileDetailRow(title: 'Giới tính', value: 'Nam'),
                ProfileDetailRow(title: 'Email', value: 'tuanle@gmail.com'),
                ProfileDetailRow(title: 'Mật khẩu', value: '**********'),
                ProfileDetailRow(title: 'Điện thoại', value: '0287493473'),
                ProfileDetailRow(
                    title: 'Địa chỉ',
                    value: '567A Sư Vạn Hạnh, phường 13, quận 10, TP.HCM'),
              ],
            ),
          ),
          //SizedBox(height: 20),
          Spacer(), // Add a Spacer to push the buttons to the bottom
          Padding(
            padding: EdgeInsets.only(bottom: 30), // Add padding to the bottom
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPasswordScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFE279), // Màu vàng
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Đổi mật khẩu',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 20), // Add space between buttons
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFE279), // Màu vàng
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Xóa tài khoản',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  final String title;
  final String value;

  ProfileDetailRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100, // Đặt một chiều rộng cố định cho phần tiêu đề
            child: Text(
              '$title:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
