import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 


class FilterScreen extends StatelessWidget {
  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showFilterSheet(context);
          },
          child: Text('Open Filter'),
        ),
      ),
    );
  }
}

class FilterSheet extends StatefulWidget {
  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  String gender = 'Nam';
  int size = 41;
  RangeValues priceRange = RangeValues(50000, 350000);
  final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
  void resetFilters() {
    setState(() {
      gender = 'Nam';
      size = 41;
      priceRange = RangeValues(50000, 350000);
    });
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
                onPressed:resetFilters ,
                child: Text('Đặt lại', style: TextStyle(fontSize: 16,color: Colors.grey)),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Text('Giới tính', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChoiceChip(
                label: Text('Nam'),
                selected: gender == 'Nam',
                selectedColor: Color(0xFF6699CC),
                onSelected: (selected) {
                  setState(() {
                    gender = 'Nam';
                  });
                },
              ),
              ChoiceChip(
                label: Text('Nữ'),
                selected: gender == 'Nữ',
                selectedColor: Color(0xFF6699CC),
                onSelected: (selected) {
                  setState(() {
                    gender = 'Nữ';
                  });
                },
              ),
              ChoiceChip(
                label: Text('Unisex'),
                selected: gender == 'Unisex',
                selectedColor: Color(0xFF6699CC),
                onSelected: (selected) {
                  setState(() {
                    gender = 'Unisex';
                  });
                },
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
            activeColor: Color(0xFF6699CC), // Set the active color to blue
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
            onPressed: () {
              // Xử lý dữ liệu lọc và đóng modal
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6699CC),
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text('Lọc',style: TextStyle(fontSize: 18,color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
