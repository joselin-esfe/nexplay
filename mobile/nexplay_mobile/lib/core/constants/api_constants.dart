class ApiConstants {
  // URL base actual del backend.
  static const String baseUrl = 'http://localhost:5290';

  // Endpoints de Paola
  static const String usersEndpoint = '/api/usuarios';
  static const String avatarsEndpoint = '/api/avatares';

  // Endpoints usados por los módulos de Joselin
  static const String loginEndpoint = '/api/auth/login';
  static const String retosEndpoint = '/api/retos';
  static const String logrosEndpoint = '/api/logros';
  static const String rankingGlobalEndpoint = '/api/ranking/global';
  static const String rankingSemanalEndpoint = '/api/ranking/semanal';
}
