class ApiConstants {
  // URL base actual del backend.
  // En Android físico seguimos usando localhost gracias a adb reverse.
  static const String baseUrl = 'http://localhost:5290';

  // Endpoints existentes de Paola
  static const String usersEndpoint = '/api/usuarios';
  static const String avatarsEndpoint = '/api/avatares';

  // Endpoints usados por los módulos de Joselin
  static const String loginEndpoint = '/api/auth/login';
}
