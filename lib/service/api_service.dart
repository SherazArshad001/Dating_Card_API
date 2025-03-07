import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio = Dio();
  Future<List<dynamic>> fetchUsers(int page) async {
    try {
      final response = await _dio.get(
        'https://randomuser.me/api/',
        queryParameters: {'page': page, 'results': 10},
      );
      return response.data['results'];
    } catch (e) {
      throw Exception("Failed to fetch User");
    }
  }
}
