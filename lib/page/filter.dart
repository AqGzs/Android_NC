import 'package:flutter/material.dart';
import 'package:flutter_doanlt/models/shoe.dart';
import 'package:intl/intl.dart';

class FilterSheet extends StatefulWidget {
  final Function(List<Shoe>) onFilterApplied;
  final List<Shoe> allShoes;

  FilterSheet({required this.onFilterApplied, required this.allShoes});

  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  RangeValues priceRange = RangeValues(100000, 200000);
  late double minPrice;
  late double maxPrice;
  final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  @override
  void initState() {
    super.initState();
    // Thiết lập minPrice và maxPrice dựa trên danh sách giày
    minPrice = widget.allShoes.map((shoe) => shoe.price).reduce((a, b) => a < b ? a : b).toDouble();
    maxPrice = widget.allShoes.map((shoe) => shoe.price).reduce((a, b) => a > b ? a : b).toDouble();
    
    // Thiết lập phạm vi giá ban đầu dựa trên minPrice và maxPrice
    priceRange = RangeValues(minPrice, maxPrice);
  }

  void resetFilters() {
    setState(() {
      priceRange = RangeValues(minPrice, maxPrice);
    });
    widget.onFilterApplied(widget.allShoes);
    Navigator.pop(context);
  }

  void applyFilters() {
    List<Shoe> filteredShoes = widget.allShoes.where((shoe) {
      return shoe.price >= priceRange.start && shoe.price <= priceRange.end;
    }).toList();

    // Sắp xếp danh sách giày đã lọc theo giá
    filteredShoes.sort((a, b) => a.price.compareTo(b.price));

    widget.onFilterApplied(filteredShoes);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                'Bộ lọc',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: resetFilters,
                child: Text('Đặt lại', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Text('Mức giá', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          RangeSlider(
            activeColor: Color(0xFF6699CC),
            values: priceRange,
            min: minPrice,
            max: maxPrice,
            divisions: (maxPrice - minPrice).toInt() ~/ 50000, // Chia các phần dựa trên khoảng giá
            labels: RangeLabels(
              currencyFormatter.format(priceRange.start),
              currencyFormatter.format(priceRange.end),
            ),
            onChanged: (values) {
              setState(() {
                priceRange = values;
              });
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: applyFilters,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6699CC),
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text('Lọc', style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
