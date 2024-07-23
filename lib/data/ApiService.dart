import 'package:dio/dio.dart';
import 'package:flutter_doanlt/data/Model/shoe.dart';
import 'package:flutter_doanlt/data/Model/user.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.68:3000/api', // Địa chỉ IP của máy tính của bạn
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));
   Future<void> addToFavorites(String userId, String shoeId) async {
    try {
      await _dio.post('/favorites', data: {'userId': userId, 'shoeId': shoeId});
    } catch (e) {
      throw Exception('Failed to add to favorites: $e');
    }
  }
 Future<List<Shoe>> getShoes({int? size, int? minPrice, int? maxPrice}) async {
    try {
      final response = await _dio.get('/shoes', queryParameters: {
        'size': size,
        'minPrice': minPrice,
        'maxPrice': maxPrice,
      });
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      if (response.statusCode == 200) {
        List<Shoe> shoes = (response.data as List).map((json) => Shoe.fromJson(json)).toList();
        return shoes;
      } else {
        throw Exception('Failed to load shoes');
      }
    } catch (error) {
      if (error is DioError) {
        print('DioError: ${error.message}');
        if (error.response != null) {
          print('DioError response: ${error.response}');
        } else {
          print('DioError error: ${error.error}');
        }
      } else {
        print('Error: $error');
      }
      throw Exception('Failed to load shoes: $error');
    }
  }

  Future<Shoe> createShoe(Shoe shoe) async {
    try {
      final response = await _dio.post(
        '/shoes',
        data: shoe.toJson(),
      );
      if (response.statusCode == 201) {
        return Shoe.fromJson(response.data);
      } else {
        throw Exception('Failed to create shoe');
      }
    } catch (error) {
      throw Exception('Failed to create shoe: $error');
    }
  }


  Future<Shoe> updateShoe(int id, Shoe shoe) async {
    try {
      final response = await _dio.put(
        '/shoes/$id',
        data: shoe.toJson(),
      );
      if (response.statusCode == 200) {
        return Shoe.fromJson(response.data);
      } else {
        throw Exception('Failed to update shoe');
      }
    } catch (error) {
      throw Exception('Failed to update shoe: $error');
    }
  }
   Future<List<Shoe>> searchShoes(String query, String token) async {
    try {
      final response = await _dio.get(
        '/shoes',
        queryParameters: {'search': query},
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Shoe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch shoes');
      }
    } catch (error) {
      throw Exception('Failed to fetch shoes: $error');
    }
  }


  Future<void> deleteShoe(int id) async {
    try {
      final response = await _dio.delete('/shoes/$id');
      if (response.statusCode != 204) {
        throw Exception('Failed to delete shoe');
      }
    } catch (error) {
      throw Exception('Failed to delete shoe: $error');
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }

  Future<User> register(User user) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: user.toJson(),
      );
      if (response.statusCode == 201) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to register');
      }
    } catch (error) {
      throw Exception('Failed to register: $error');
    }
  }
  
}



