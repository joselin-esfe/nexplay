class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'NEXPLAY_API_BASE_URL',
    defaultValue: 'http://127.0.0.1:5290',
  );

  // Endpoints existentes de Paola
  static const String usersEndpoint = '/api/usuarios';
  static const String avatarsEndpoint = '/api/avatares';

  // Endpoints usados por los módulos de Joselin
  static const String loginEndpoint = '/api/auth/login';
  static const String juegosEndpoint = '/api/juegos';
  static const String categoriasEndpoint = '/api/categorias';
}
