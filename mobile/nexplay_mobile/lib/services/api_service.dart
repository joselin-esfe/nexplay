import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/api_constants.dart';
import '../models/achievement_model.dart';
import '../models/challenge_model.dart';
import '../models/ranking_user_model.dart';

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

  // Obtener Retos reales desde el Backend
  static Future<List<ChallengeModel>> getRetos() async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.retosEndpoint}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => ChallengeModel.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // Obtener Logros reales desde el Backend
  static Future<List<AchievementModel>> getLogros() async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.logrosEndpoint}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => AchievementModel.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // Obtener Ranking Global real desde el Backend
  static Future<List<RankingUserModel>> getRankingGlobal() async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.rankingGlobalEndpoint}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.asMap().entries.map((entry) => RankingUserModel.fromJson(entry.value, index: entry.key)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // Obtener Ranking Semanal real desde el Backend
  static Future<List<RankingUserModel>> getRankingSemanal() async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.rankingSemanalEndpoint}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.asMap().entries.map((entry) => RankingUserModel.fromJson(entry.value, index: entry.key)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // Obtener Ranking Mensual real desde el Backend
  static Future<List<RankingUserModel>> getRankingMensual() async {
    return [];
  }
}
