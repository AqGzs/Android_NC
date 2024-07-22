import 'package:dio/dio.dart';
import 'package:flutter_doanlt/models/user.dart';
import 'package:flutter_doanlt/api_service/dio_config.dart';


class UserService {
   final Dio _dio = DioConfig.instance;

  Future<User> getUserDetails(String userId, String token) async {
    try {
      final response = await _dio.get(
        '/users/$userId',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch user details');
      }
    } catch (error) {
      throw Exception('Failed to fetch user details: $error');
    }
  }
 Future<User> updateUserDetails(String userId, String token, Map<String, dynamic> updateData) async {
    try {
      final response = await _dio.put(
        '/users/$userId',
        data: updateData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to update user details: $e');
    }
  }
}
