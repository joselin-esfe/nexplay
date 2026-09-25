class ApiConstants {
  // Para emulador Android usar 10.0.2.2:5290
  // Para dispositivo físico usar la IP local de tu PC
  static const String baseUrl = 'http://10.0.2.2:5290';

  static const String loginEndpoint = '/api/auth/login';
  static const String juegosEndpoint = '/api/juegos';
  static const String categoriasEndpoint = '/api/categorias';
}
