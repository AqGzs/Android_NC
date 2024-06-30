import 'package:flutter/material.dart';


class AccountSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF6699CC),
          leading: Padding(
            padding:
                const EdgeInsets.only(left: 16.0), // Add padding to the left
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
              'Cài đặt',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0), // Add padding to the right
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
                  child: Icon(Icons.person, size: 20), // Reduce icon size
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF6699CC),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
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
                    //SizedBox(height: 16.0),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 0.0), // Add margin to create a gap
                      child: ListTile(
                        leading: Icon(Icons.layers),
                        title: Text('Thông tin tài khoản'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {},
                      ),
                    ),
                    Divider(), // Add a Divider here
                    Container(
                      margin: EdgeInsets.only(
                          top: 0.0, bottom: 0.0), // Add margin to create a gap
                      child: ListTile(
                        leading: Icon(Icons.language),
                        title: Text('Chính sách bảo mật'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {},
                      ),
                    ),
                    Divider(), // Add a Divider here
                    Container(
                      margin: EdgeInsets.only(
                          top: 0.0), // Add margin to create a gap
                      child: ListTile(
                        leading: Icon(Icons.brightness_low),
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
                    //SizedBox(height: 16.0),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 0.0), // Add margin to create a gap
                      child: ListTile(
                        leading: Icon(Icons.layers),
                        title: Text('Kiểm tra phiên bản'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {},
                      ),
                    ),
                    Divider(), // Add a Divider here
                    Container(
                      margin: EdgeInsets.only(
                          top: 0.0, bottom: 0.0), // Add margin to create a gap
                      child: ListTile(
                        leading: Icon(Icons.language),
                        title: Text('Ngôn ngữ'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {},
                      ),
                    ),
                    Divider(), // Add a Divider here
                    Container(
                      margin: EdgeInsets.only(
                          top: 0.0), // Add margin to create a gap
                      child: ListTile(
                        leading: Icon(Icons.brightness_low),
                        title: Text('Giao diện'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8.0),
                      Text('Đăng xuất',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_outlined),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
          currentIndex: 4,
          selectedItemColor: Colors.brown,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
