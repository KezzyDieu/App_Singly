import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  //static const String baseUrl = 'http://10.0.2.2:3000/api/quiz';
  //static const String baseUrl = 'http://192.168.19.46:3000/api/quiz'; // O cambia según tu IP
  static const String baseUrl = 'https://apisofccey.onrender.com/api/quiz';

  static Future<String?> obtenerUltimaLetra() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/ultima-letra'));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        return json['letra'];
      }
    } catch (e) {
      print('❌ Error obteniendo letra: $e');
    }
    return null;
  }
}
