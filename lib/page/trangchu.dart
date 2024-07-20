import 'package:dio/dio.dart'; // Add Dio package for HTTP requests
import 'package:flutter/material.dart';
import 'package:flutter_doanlt/data/Model/shoe.dart'; // Import Shoe model
import 'package:flutter_doanlt/favorite/favorite.dart';
import 'package:flutter_doanlt/notification/notification.dart';
import 'package:flutter_doanlt/page/cart_screen.dart';
import 'package:flutter_doanlt/page/product_list_screen.dart';
import 'package:flutter_doanlt/page/profile_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _screens = [
    HomePageContent(),
    FavoriteScreen(),
    CartScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
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
        currentIndex: _currentIndex,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
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
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen()));
              },
            ),
          ),
        ],
      ),
      body: HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
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
      var response = await Dio().get('http://192.168.1.181:3000/api/shoes'); // Replace with your API URL
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
    List<Shoe> allShoes = products.take(5).toList();
    List<Shoe> newShoes = List.from(products);
    newShoes.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Ensure you have createdAt field in Shoe model

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Color(0xFF6699CC),
                title: TextField(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        title: 'Tất cả giày',
                        onViewAll: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProductListScreen()),
                          );
                        },
                      ),
                      SizedBox(height: 10.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: allShoes.map((shoe) {
                            return GestureDetector(
                              onTap: () {
                                // Implement navigation to detail screen
                              },
                              child: ProductCard(
                                imagePath: shoe.imageUrl,
                                name: shoe.name,
                                price: '${shoe.price}đ',
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SectionTitle(
                        title: 'Sản Phẩm Mới',
                        onViewAll: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProductListScreen()),
                          );
                        },
                      ),
                      SizedBox(height: 10.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: newShoes.map((shoe) {
                            return GestureDetector(
                              onTap: () {
                                // Implement navigation to detail screen
                              },
                              child: ProductCard1(
                                imagePath: shoe.imageUrl,
                                name: shoe.name,
                                price: '${shoe.price}đ',
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
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

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  SectionTitle({required this.title, required this.onViewAll});

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
          child: Text('Xem thêm', style: TextStyle(color: Colors.black54)),
        ),
      ],
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)),
                      child: Image.network(
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
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
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

class ProductCard1 extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;

  ProductCard1({
    required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 350,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 180,
                child: Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Row(
                            children: [
                              Text(
                                'ĐƯỢC ƯA CHUỘNG',
                                style: TextStyle(
                                  color: Color(0xFF5B9EE1),
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
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
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          imagePath,
                          fit: BoxFit.contain,
                          height: 130.0,
                          width: 170.0,
                        ),
                      ),
                      Positioned(
                        top: 20.0,
                        left: 10.0,
                        child: FavoriteButton(),
                      ),
                    ],
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