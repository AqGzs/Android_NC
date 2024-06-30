import 'package:flutter/material.dart';


class EditProfileScreen extends StatelessWidget {
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 20),
              Text('Thay đổi thông tin thành công !',
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6699CC), // Màu nền xanh
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
            'Thay đổi thông tin',
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
              onTap: () {}, // Add tap callback
              splashColor: Color(0xFF6699CC),
              hoverColor: Color(0xFF6699CC), // Remove splash effect
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  shape: BoxShape.circle, // Circular shape
                ),
                padding: const EdgeInsets.all(8.0), // Add padding to the icon
                child:
                    Icon(Icons.edit, color: Colors.black), // Reduce icon size
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.png'),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.camera_alt,
                      size: 15, color: Color(0xFF80A7D3)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    // Wrap the text with a Center widget
                    child: Text(
                      'Thông tin tài khoản',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ProfileDetailRow(
                      title: 'Họ và tên',
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Lê Minh Tuấn',
                          filled: true,
                          fillColor: Colors.grey[400],
                        ),
                      )),
                  ProfileDetailRow(
                      title: 'Ngày sinh',
                      child: Row(
                        children: [
                          Expanded(
                              child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[400],
                            ),
                            items: List.generate(
                                31,
                                (index) => DropdownMenuItem(
                                      child: Text((index + 1).toString()),
                                      value: (index + 1).toString(),
                                    )),
                            onChanged: (value) {},
                          )),
                          SizedBox(width: 8),
                          Expanded(
                              child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[400],
                            ),
                            items: [
                              DropdownMenuItem(
                                  child: Text('Tháng 1'), value: 'Tháng 1'),
                              DropdownMenuItem(
                                  child: Text('Tháng 2'), value: 'Tháng 2'),
                              DropdownMenuItem(
                                  child: Text('Tháng 3'), value: 'Tháng 3'),
                              DropdownMenuItem(
                                  child: Text('Tháng 4'), value: 'Tháng 4'),
                              DropdownMenuItem(
                                  child: Text('Tháng 5'), value: 'Tháng 5'),
                              DropdownMenuItem(
                                  child: Text('Tháng 6'), value: 'Tháng 6'),
                              DropdownMenuItem(
                                  child: Text('Tháng 7'), value: 'Tháng 7'),
                              DropdownMenuItem(
                                  child: Text('Tháng 8'), value: 'Tháng 8'),
                              DropdownMenuItem(
                                  child: Text('Tháng 9'), value: 'Tháng 9'),
                              DropdownMenuItem(
                                  child: Text('Tháng 10'), value: 'Tháng 10'),
                              DropdownMenuItem(
                                  child: Text('Tháng 11'), value: 'Tháng 11'),
                              DropdownMenuItem(
                                  child: Text('Tháng 12'), value: 'Tháng 12'),
                              // Add more months
                            ],
                            onChanged: (value) {},
                          )),
                          SizedBox(width: 8),
                          Expanded(
                              child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[400],
                            ),
                            items: List.generate(
                                150,
                                (index) => DropdownMenuItem(
                                      child: Text((1920 + index).toString()),
                                      value: (1920 + index).toString(),
                                    )),
                            onChanged: (value) {},
                          )),
                        ],
                      )),
                  ProfileDetailRow(
                      title: 'Giới tính',
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[400],
                        ),
                        items: [
                          DropdownMenuItem(child: Text('Nam'), value: 'Nam'),
                          DropdownMenuItem(child: Text('Nữ'), value: 'Nữ'),
                          // Add more options if needed
                        ],
                        onChanged: (value) {},
                      )),
                  ProfileDetailRow(
                      title: 'Điện thoại',
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '0287493473',
                          filled: true,
                          fillColor: Colors.grey[400],
                        ),
                      )),
                  ProfileDetailRow(
                      title: 'Địa chỉ',
                      child: TextField(
                        //maxLines: 3,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              '567A Sư Vạn Hạnh, phường 13, quận 10, TP.HCM',
                          filled: true,
                          fillColor: Colors.grey[400],
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  _showSuccessDialog(
                      context); // Xử lý khi nhấn nút lưu thay đổi
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFE279), // Màu vàng
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Lưu thay đổi',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  final String title;
  final Widget child;

  ProfileDetailRow({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
