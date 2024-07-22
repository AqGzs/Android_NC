import 'package:flutter/material.dart';

import 'package:flutter_doanlt/api_service/shoe_service.dart';
 
import 'package:flutter_doanlt/models/shoe.dart';
import 'package:intl/intl.dart'; 
class FilterSheet extends StatefulWidget {
  final Function(List<Shoe>) onFilterApplied;

  FilterSheet({required this.onFilterApplied});

  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  int size = 41;
  RangeValues priceRange = RangeValues(50000, 350000);
  final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  void resetFilters() {
    setState(() {
      size = 41;
      priceRange = RangeValues(50000, 350000);
    });
  }

  void applyFilters() async {
    ShoeService apiService = ShoeService();
    List<Shoe> filteredShoes = await apiService.getShoes(
      size: size,
      minPrice: priceRange.start.toInt(),
      maxPrice: priceRange.end.toInt(),
    );
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
          Text('Kích cỡ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 10.0),
          Wrap(
            spacing: 8.0,
            children: [
              for (int i = 38; i <= 43; i++)
                ChoiceChip(
                  label: Text('$i'),
                  selected: size == i,
                  selectedColor: Color(0xFF6699CC),
                  onSelected: (selected) {
                    setState(() {
                      size = i;
                    });
                  },
                ),
            ],
          ),
          SizedBox(height: 20.0),
          Text('Mức giá', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          RangeSlider(
            activeColor: Color(0xFF6699CC),
            values: priceRange,
            min: 50000,
            max: 350000,
            divisions: 6,
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
