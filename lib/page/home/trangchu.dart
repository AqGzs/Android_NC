import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doanlt/api_service/shoe_service.dart';
import 'package:flutter_doanlt/models/shoe.dart';
import 'package:flutter_doanlt/notification/notification.dart';
import 'package:flutter_doanlt/page/account_setting_screen.dart';
import 'package:flutter_doanlt/page/favorite/favorite.dart';
import 'package:flutter_doanlt/page/home/category_button.dart';
import 'package:flutter_doanlt/page/home/product_card1.dart';
import 'package:flutter_doanlt/page/productDetailScreen.dart';
import 'package:flutter_doanlt/page/product_list/product_list_screen.dart';
import 'package:flutter_doanlt/page/search.dart';

class HomePage extends StatefulWidget {
  final String token;
  final String userId;

  HomePage({required this.token, required this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late List<Widget> _screens;
  late List<String> _titles;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomePageContent(token: widget.token, userId: widget.userId),
      FavoriteScreen(),
      NotificationScreen(),
      AccountSettingScreen(token: widget.token, userId: widget.userId),
    ];
    _titles = ['F5Store', 'Yêu thích', 'Thông báo', 'Cài đặt'];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6699CC),
      appBar: AppBar(
        backgroundColor: Color(0xFF6699CC),
        elevation: 0,
        leading: Icon(Icons.menu),
        title: Center(
          child: Text(
            _titles[_selectedIndex],
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 238, 238, 236),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
            child: InkWell(
              onTap: () {
                // Handle cart button tap
              },
              splashColor: Colors.white,
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
class HomePageContent extends StatefulWidget {
  final String token;
  final String userId;

  HomePageContent({required this.token, required this.userId});

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  String selectedCategory = '';
  List<Shoe> shoes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  Future<void> _loadProducts() async {
    ShoeService apiService = ShoeService();
    try {
      List<Shoe> fetchedShoes = await apiService.getShoes();
      setState(() {
        shoes = fetchedShoes;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6699CC), // Set the main background color here
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : shoes.isNotEmpty
                ? CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: Color(0xFF6699CC),
                        automaticallyImplyLeading: false,
                        title: TextField(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SearchScreen(token: widget.token)),
                            );
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Tìm kiếm',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0), // Add some space between the search bar and the carousel
                            CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                viewportFraction: 1.0, // Use full width
                                aspectRatio: 16 / 9,
                              ),
                              items: [
                                'assets/images/carousel1.jpg',
                                'assets/images/carousel2.jpg',
                                'assets/images/carousel3.jpg',
                              ].map((imagePath) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        imagePath,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 220.0,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 24.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CategoryButton(
                                  iconPath: 'assets/images/logo_nike.png',
                                  isSelected: selectedCategory == 'Nike',
                                  label: 'Nike',
                                  onTap: () => selectCategory('Nike'),
                                ),
                                CategoryButton(
                                  iconPath: 'assets/images/logo_puma.png',
                                  isSelected: selectedCategory == 'Puma',
                                  label: 'Puma',
                                  onTap: () => selectCategory('Puma'),
                                ),
                                CategoryButton(
                                  iconPath: 'assets/images/logo_underarmour.png',
                                  isSelected: selectedCategory == 'Under Armour',
                                  label: 'Under Armour',
                                  onTap: () => selectCategory('Under Armour'),
                                ),
                                CategoryButton(
                                  iconPath: 'assets/images/logo_adidas.png',
                                  isSelected: selectedCategory == 'Adidas',
                                  label: 'Adidas',
                                  onTap: () => selectCategory('Adidas'),
                                ),
                                CategoryButton(
                                  iconPath: 'assets/images/logo_converse.png',
                                  isSelected: selectedCategory == 'Converse',
                                  label: 'Converse',
                                  onTap: () => selectCategory('Converse'),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.0),
                            Divider(color: Colors.black54),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SectionTitle(
                                title: 'Nổi Bật',
                                token: widget.token,
                                userId: widget.userId,
                                onViewAll: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductListScreen(userId: widget.userId, token: widget.token),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              color: Color(0xFF6699CC),
                              child: shoes.isNotEmpty
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: shoes.map((shoe) => ProductCard1(shoe: shoe)).toList(),
                                      ),
                                    )
                                  : Center(child: Text('Không tìm thấy sản phẩm')),
                            ),
                            SizedBox(height: 24.0),
                            Divider(color: Colors.black54),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SectionTitle(
                                title: 'Sản Phẩm Mới',
                                token: widget.token,
                                userId: widget.userId,
                                onViewAll: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(shoe: shoes.first), // Assuming you pass a shoe
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              color: Color(0xFF6699CC),
                              child: shoes.isNotEmpty
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: shoes.map((shoe) => ProductCard1(shoe: shoe)).toList(),
                                      ),
                                    )
                                  : Center(child: Text('Không tìm thấy sản phẩm')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(child: Text('Không tìm thấy sản phẩm')),
      ),
    );
  }
}
class SectionTitle extends StatelessWidget {
  final String title;
  final String userId;
  final String token;
  final VoidCallback onViewAll;

  SectionTitle({required this.title, required this.token, required this.userId, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: onViewAll,
          child: Text('Xem thêm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
        ),
      ],
    );
  }
} 


class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
      child: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        size: 30.0,
        color: _isFavorite ? Colors.red : Colors.black,
      ),
    );
  }
}
