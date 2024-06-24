import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String _selectedGender = 'Nam';
  int _selectedSize = 41;
  double _currentRangeValues = 200000;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Bộ lọc', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedGender = 'Nam';
                    _selectedSize = 41;
                    _currentRangeValues = 200000;
                  });
                },
                child: Text('Đặt lại', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Giới tính', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildGenderOption('Nam'),
              _buildGenderOption('Nữ'),
              _buildGenderOption('Đa giới'),
            ],
          ),
          SizedBox(height: 20),
          Text('Kích cỡ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 10.0,
            children: List.generate(6, (index) {
              int size = 38 + index;
              return ChoiceChip(
                label: Text(size.toString()),
                selected: _selectedSize == size,
                onSelected: (bool selected) {
                  setState(() {
                    _selectedSize = size;
                  });
                },
              );
            }),
          ),
          SizedBox(height: 20),
          Text('Mức giá', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Slider(
            value: _currentRangeValues,
            min: 50000,
            max: 350000,
            divisions: 100,
            label: _currentRangeValues.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentRangeValues = value;
              });
            },
          ),
          Text('50.000đ - ${_currentRangeValues.round()}đ', style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Thêm logic lọc tại đây
            },
            child: Text('Lọc', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    return ChoiceChip(
      label: Text(gender),
      selected: _selectedGender == gender,
      onSelected: (bool selected) {
        setState(() {
          _selectedGender = gender;
        });
      },
    );
  }
}
