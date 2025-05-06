import 'dart:convert';
import 'package:firebasewithnotification/model/postman_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://172.233.67.77:2020/api';
  final String _baseUrl = 'http://172.233.67.77:2020/api';

  Future<User?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data['Token'];
        final userJson = data['User'];

        return User.fromLoginJson(userJson, token);
      } else {
        print('Login failed: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<User?> register(
      String name, String email, String password, String phone) async {
    final url = Uri.parse('$_baseUrl/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return User.fromRegisterJson(data['User']);
    } else {
      print('Registration failed: ${response.body}');
      return null;
    }
  }
}
