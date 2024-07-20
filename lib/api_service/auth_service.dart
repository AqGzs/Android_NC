import 'package:dio/dio.dart';
import 'package:flutter_doanlt/models/user.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.125:3000/api', // Địa chỉ IP của máy tính của bạn
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  // 5 seconds
  ))..interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  
 Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        return response.data;
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
