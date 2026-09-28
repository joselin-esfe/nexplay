import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/api_constants.dart';

class ApiService {
  // Login
  static Future<Map<String, dynamic>> login(String correo, String contrasena) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'correo': correo,
          'password': contrasena,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        if (data['token'] != null) {
          await prefs.setString('auth_token', data['token']);
        }
        if (data['id'] != null || data['usuarioId'] != null) {
          final userId = data['id'] ?? data['usuarioId'];
          await prefs.setInt('user_id', userId is int ? userId : int.parse(userId.toString()));
        }
        return {'success': true, 'data': data};
      } else {
        final errorBody = response.body;
        return {'success': false, 'message': errorBody.isNotEmpty ? errorBody : 'Credenciales inválidas'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error de conexión: $e'};
    }
  }
}
