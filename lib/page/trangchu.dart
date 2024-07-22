import 'package:dio/dio.dart'; // Add Dio package for HTTP requests
import 'package:flutter/material.dart';
import 'package:flutter_doanlt/data/Model/shoe.dart'; // Import Shoe model
import 'package:flutter_doanlt/detail/productDetailScreen.dart';
import 'package:flutter_doanlt/favorite/favorite.dart';
import 'package:flutter_doanlt/notification/notification.dart';
import 'package:flutter_doanlt/page/account_setting_screen.dart';
import 'package:flutter_doanlt/page/cart_screen.dart';
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
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountSettingScreen(token: widget.token, userId: widget.userId)),
      );
    }
  }

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      HomePageContent(token: widget.token, userId: widget.userId),
      FavoriteScreen(),
      CartScreen(),
      NotificationScreen(),
      AccountSettingScreen(token: widget.token, userId: widget.userId),
    ]);
  }

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
  final String token;
  final String userId;

  HomePageContent({required this.token, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6699CC),
      appBar: AppBar(
        backgroundColor: Color(0xFF6699CC),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
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
              child: Icon(Icons.grid_view_rounded, size: 20),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Text(
              'F5Store',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
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
      body: HomePageBody(token: token, userId: userId),
    );
  }
}

class HomePageBody extends StatefulWidget {
  final String token;
  final String userId;

  HomePageBody({required this.token, required this.userId});

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

  void _navigateToDetailScreen(Shoe shoe) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailScreen(shoe: shoe)),
    );
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
                        MaterialPageRoute(builder: (context) => SearchScreen()),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CategoryButton(
                                iconPath: 'assets/images/logo_nike.png',
                                label: 'Nike',
                                isSelected: selectedCategory == 'Nike',
                                onTap: () => selectCategory('Nike'),
                              ),
                              SizedBox(width: 25.0),
                              CategoryButton(
                                iconPath: 'assets/images/logo_puma.png',
                                label: 'Puma',
                                isSelected: selectedCategory == 'Puma',
                                onTap: () => selectCategory('Puma'),
                              ),
                              SizedBox(width: 25.0),
                              CategoryButton(
                                iconPath: 'assets/images/logo_underarmour.png',
                                label: 'Underarmour',
                                isSelected: selectedCategory == 'Under Armour',
                                onTap: () => selectCategory('Under Armour'),
                              ),
                              SizedBox(width: 25.0),
                              CategoryButton(
                                iconPath: 'assets/images/logo_adidas.png',
                                label: 'Adidas',
                                isSelected: selectedCategory == 'Adidas',
                                onTap: () => selectCategory('Adidas'),
                              ),
                              SizedBox(width: 25.0),
                              CategoryButton(
                                iconPath: 'assets/images/logo_converse.png',
                                label: 'Converse',
                                isSelected: selectedCategory == 'Converse',
                                onTap: () => selectCategory('Converse'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        SectionTitle(
                          title: 'Nổi Bật',
                          onViewAll: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductListScreen()),
                            );
                          },
                        ),
                        SizedBox(height: 10.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: products.map((shoe) {
                              return GestureDetector(
                                onTap: () => _navigateToDetailScreen(shoe),
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
                              MaterialPageRoute(
                                  builder: (context) => ProductListScreen()),
                            );
                          },
                        ),
                        SizedBox(height: 10.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: products.map((shoe) {
                              return GestureDetector(
                                onTap: () => _navigateToDetailScreen(shoe),
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
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class CategoryButton extends StatefulWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  CategoryButton({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(_controller);
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
        if (widget.isSelected) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: widget.isSelected ? Color(0xFFFEB941) : Colors.transparent,
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: widget.isSelected
            ? Row(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFE279),
                    ),
                    child: Center(
                      child: Image.asset(widget.iconPath,
                          width: 35.0, height: 35.0),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: Text(
                      widget.label,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            : Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFE279),
                ),
                child: Center(
                  child:
                      Image.asset(widget.iconPath, width: 40.0, height: 40.0),
                ),
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
                    padding: EdgeInsets.only(top: 20.0),
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
                    width: 45.0,
                    height: 45.0,
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
