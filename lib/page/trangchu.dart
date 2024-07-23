import 'package:carousel_slider/carousel_slider.dart'; // Import CarouselSlider package
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doanlt/data/Model/shoe.dart'; // Import Shoe model
import 'package:flutter_doanlt/favorite/favorite.dart';
import 'package:flutter_doanlt/notification/notification.dart';
import 'package:flutter_doanlt/page/account_setting_screen.dart';
import 'package:flutter_doanlt/page/product_card1.dart';
import 'package:flutter_doanlt/page/product_list_screen.dart';
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
  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      HomePageContent(token: widget.token, userId: widget.userId),
      FavoriteScreen(),
      NotificationScreen(),
      AccountSettingScreen(token: widget.token, userId: widget.userId),
    ];
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
            'F5Store',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
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
              splashColor: Color(0xFF6699CC),
              hoverColor: Color(0xFF6699CC),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_bag_rounded, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
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
  List<Shoe> products = [];
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
    try {
      var response = await Dio().get('http://192.168.1.78:3000/api/shoes'); // Replace with your API URL
      List<dynamic> data = response.data;
      List<Shoe> loadedProducts = data.map((json) => Shoe.fromJson(json)).toList();
      setState(() {
        products = loadedProducts;
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
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: products.isNotEmpty
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CategoryButton(
                            iconPath: 'assets/images/logo_nike.png',
                            isSelected: selectedCategory == 'Nike',
                            onTap: () => selectCategory('Nike'),
                          ),
                          CategoryButton(
                            iconPath: 'assets/images/logo_puma.png',
                            isSelected: selectedCategory == 'Puma',
                            onTap: () => selectCategory('Puma'),
                          ),
                          CategoryButton(
                            iconPath: 'assets/images/logo_underarmour.png',
                            isSelected: selectedCategory == 'Under Armour',
                            onTap: () => selectCategory('Under Armour'),
                          ),
                          CategoryButton(
                            iconPath: 'assets/images/logo_adidas.png',
                            isSelected: selectedCategory == 'Adidas',
                            onTap: () => selectCategory('Adidas'),
                          ),
                          CategoryButton(
                            iconPath: 'assets/images/logo_converse.png',
                            isSelected: selectedCategory == 'Converse',
                            onTap: () => selectCategory('Converse'),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      SectionTitle(
                        title: 'Nổi Bật',
                        token: widget.token,
                        userId: widget.userId,
                        onViewAll: () {},
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        color: Color(0xFF6699CC),
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : products.isNotEmpty
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: products.map((shoe) => ProductCard1(shoe: shoe)).toList(),
                                    ),
                                  )
                                : Center(child: Text('Không tìm thấy sản phẩm')),
                      ),
                      SizedBox(height: 16.0),
                      SectionTitle(
                        title: 'Sản Phẩm Mới',
                        token: widget.token,
                        userId: widget.userId,
                        onViewAll: () {},
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        color: Color(0xFF6699CC),
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : products.isNotEmpty
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: products.map((shoe) => ProductCard1(shoe: shoe)).toList(),
                                    ),
                                  )
                                : Center(child: Text('Không tìm thấy sản phẩm')),
                      ),
                      SizedBox(height: 16.0),
                      SectionTitle(
                        title: 'Gợi ý',
                        token: widget.token,
                        userId: widget.userId,
                        onViewAll: () {},
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 3 / 4,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProductCard3(shoe: products[index]);
                      },
                      childCount: products.length,
                    ),
                  ),
                ),
              ],
            )
          : Center(child: Text('Không tìm thấy sản phẩm')),
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductListScreen(token: token, userId: userId),
              ),
            );
          },
          child: Text('Xem thêm', style: TextStyle(color: Colors.black54)),
        ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  CategoryButton({
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFEB941) : Color(0xFFFFE279),
          borderRadius: BorderRadius.circular(35.0),
          border: Border.all(
            color: isSelected ? Color(0xFFFEB941) : Color(0xFF6699CC),
            width: 3.0,
          ),
        ),
        child: Column(
          children: [
            Image.asset(iconPath, width: 40.0, height: 40.0),
          ],
        ),
      ),
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

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;

  ProductCard({
    required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 110.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'THỊNH HÀNH',
                          style: TextStyle(
                            color: Color(0xFF5B9EE1),
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10.0,
                left: 10.0,
                child: FavoriteButton(),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: InkWell(
                  onTap: () {
                    // handle tap event here
                  },
                  splashColor: Colors.white,
                  child: Container(
                    width: 50.0, // adjust the width
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ), // adjust the radius to your liking
                    ),
                    child: Icon(
                      Icons.add,
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
}

class ProductCard3 extends StatelessWidget {
  final Shoe shoe;

  ProductCard3({required this.shoe});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                  child: Image.asset(
                    shoe.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 110.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'THỊNH HÀNH',
                      style: TextStyle(
                        color: Color(0xFF5B9EE1),
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      shoe.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      '\$${shoe.price}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10.0,
            left: 10.0,
            child: FavoriteButton(),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: InkWell(
              onTap: () {
                // handle tap event here
              },
              splashColor: Colors.white,
              child: Container(
                width: 50.0, // adjust the width
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ), // adjust the radius to your liking
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
