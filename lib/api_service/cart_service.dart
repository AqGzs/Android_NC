import 'package:dio/dio.dart';
import 'package:flutter_doanlt/api_service/dio_config.dart';
import 'package:flutter_doanlt/models/cart_item.dart';

class CartService {
  final Dio _dio = DioConfig.instance;

  
  Future<void> createCart(String userId, List<Map<String, dynamic>> items, String token) async {
  Map<String, dynamic> cartData = {
    'userId': userId,
    'items': items,
  };

  try {
    final response = await _dio.post(
      '/carts',
      data: cartData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 201) {
      print('Cart created successfully: ${response.data}');
    } else {
      print('Failed to create cart: ${response.statusCode}');
    }
  } catch (e) {
    if (e is DioError) {
      print('Dio error: ${e.response?.data}');
    } else {
      print('Error: $e');
    }
  }
}

 Future<List<Map<String, dynamic>>> getCartItems(String userId, String token) async {
  final response = await _dio.get(
    '/carts/$userId',
    options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ),
  );

  if (response.statusCode == 200) {
    List<Map<String, dynamic>> cartItems = (response.data['items'] as List).map((item) {
      final product = item['productId'];
      final stock = item['stock'];
      return {
        'productId': product['_id'],
        'quantity': item['quantity'],
        'stockId': stock.id,
        'title': product['name'],
        'image': product['imageUrl'],
        'price': product['price'],
        'size': stock['size'],
      };
    }).toList();
    return cartItems;
  } else {
    throw Exception('Failed to load cart items');
  }
}


   Future<void> updateCartItemQuantity(String cartItemId, int quantity, String token) async {
    try {
      final response = await _dio.put(
        'carts/item/$cartItemId',
        data: {'quantity': quantity},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update cart item quantity');
      }
    } catch (e) {
      throw Exception('Error updating cart item quantity: $e');
    }
  }


  Future<void> deleteCart(String cartId, String token) async {
    try {
      await _dio.delete(
        '/carts/$cartId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      if (e is DioError) {
        return Future.error(e.response?.data ?? 'An error occurred');
      } else {
        return Future.error('An unexpected error occurred');
      }
    }
  }
}
