import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/api_constants.dart';
import '../models/game_model.dart';
import '../models/category_model.dart';

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

  // Obtener todos los juegos
  static Future<List<GameModel>> getJuegos() async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.juegosEndpoint}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => GameModel.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar juegos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Obtener categorías
  static Future<List<CategoryModel>> getCategorias() async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.categoriasEndpoint}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => CategoryModel.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar categorías: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Obtener juegos por categoría
  static Future<List<GameModel>> getJuegosPorCategoria(int categoriaId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.categoriasEndpoint}/$categoriaId/juegos');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => GameModel.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar juegos de la categoría: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
