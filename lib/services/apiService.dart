import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<http.Response> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final body = jsonEncode({'email': email, 'password': password});
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }

  Future<http.Response> register(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/register');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  Future<http.Response> loginWithGoogle() async {
    final url = Uri.parse('$baseUrl/auth/google');
    return await http.get(url);
  }

  Future<http.Response> loginWithFacebook() async {
    final url = Uri.parse('$baseUrl/auth/facebook');
    return await http.get(url);
  }
}
