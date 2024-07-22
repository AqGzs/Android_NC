import 'package:flutter/material.dart';
import 'package:flutter_doanlt/data/ApiService.dart';
import 'package:flutter_doanlt/data/Model/shoe.dart';
import 'package:flutter_doanlt/page/filter.dart';
import 'package:flutter_doanlt/page/product_card.dart';
import 'package:flutter_doanlt/page/search.dart';
class ProductListScreen extends StatefulWidget {
    final String token; 

    ProductListScreen({required this.token});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Shoe> shoes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    ApiService apiService = ApiService();
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

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FilterSheet(onFilterApplied: (filteredShoes) {
          setState(() {
            shoes = filteredShoes;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Giày Nike',
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen(token: widget.token)),
                );
              },
              splashColor: Color(0xFF6699CC),
              hoverColor: Color(0xFF6699CC),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search, size: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
            child: InkWell(
              onTap: _openFilterSheet,
              splashColor: Color(0xFF6699CC),
              hoverColor: Color(0xFF6699CC),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.filter_list, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Container(
          color: Color(0xFF6699CC),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : shoes.isNotEmpty
                  ? GridView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: shoes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        return ProductCard(shoe: shoes[index]);
                      },
                    )
                  : Center(child: Text('Không tìm thấy sản phẩm')),
        ),
      ),
    );
  }
}
