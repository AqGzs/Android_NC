import 'package:dio/dio.dart';
import 'package:flutter_doanlt/api_service/dio_config.dart';
import 'package:flutter_doanlt/models/cart.dart';

class CartService {
  final Dio _dio = DioConfig.instance;

  
  Future<void> createCart(String userId, String productId, String stockId, int quantity, String token) async {
    Map<String, dynamic> cartData = {
      'userId': userId,
      'items': [
        {
          'productId': productId,
          'stockId': stockId, // Ensure the field is correctly named as 'stockId'
          'quantity': quantity
        }
      ],
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

  Future<List<Map<String, dynamic>>> getCart(String userId, String token) async {
    try {
      final response = await _dio.get(
        '/carts/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return List<Map<String, dynamic>>.from(response.data['items']);
    } catch (e) {
      if (e is DioError) {
        print('Dio error: ${e.response?.data}');
      } else {
        print('Error: $e');
      }
      return [];
    }
  }

  Future<Cart> updateCart(String cartId, Map<String, dynamic> cartData, String token) async {
    try {
      final response = await _dio.put(
        '/carts/$cartId',
        data: cartData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return Cart.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        return Future.error(e.response?.data ?? 'An error occurred');
      } else {
        return Future.error('An unexpected error occurred');
      }
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
