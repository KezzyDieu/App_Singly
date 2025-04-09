import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  //static const String baseUrl = 'http://10.0.2.2:3000/api/auth';
  //static const String baseUrl = 'http://192.168.19.46:3000/api/auth';
  static const String baseUrl = 'https://apisofccey.onrender.com/api/auth';

  static Future<Map<String, dynamic>> register(String nombre, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nombre': nombre,
        'email': email,
        'password': password,
      }),
    );
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    return json.decode(response.body);
  }
}
