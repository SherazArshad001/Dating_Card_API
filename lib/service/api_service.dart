import 'package:dating_card_api/model/user_model.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio = Dio();
  Future<List<dynamic>> fetchUsers(int page) async {
    try {
      final response = await _dio.get(
        'https://randomuser.me/api/',
        queryParameters: {'page': page, 'results': 10},
      );
      if (response.statusCode == 200) {
        List<dynamic> result = response.data['results'];
        return result.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      throw Exception("Failed to fetch User");
    }
  }
}
