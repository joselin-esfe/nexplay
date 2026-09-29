class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'NEXPLAY_API_BASE_URL',
    defaultValue: 'http://127.0.0.1:5290',
  );

  // Endpoints existentes
  static const String usersEndpoint = '/api/usuarios';
  static const String avatarsEndpoint = '/api/avatares';
  static const String loginEndpoint = '/api/auth/login';

  // Juegos
  static const String juegosEndpoint = '/api/juegos';
  static const String categoriasEndpoint = '/api/categorias';

  // Módulos de Joselin
  static const String retosEndpoint = '/api/retos';
  static const String logrosEndpoint = '/api/logros';
  static const String rankingGlobalEndpoint = '/api/ranking/global';
  static const String rankingSemanalEndpoint = '/api/ranking/semanal';
}
