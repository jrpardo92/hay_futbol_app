// lib/app/services/auth_service.dart
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../data/models/user_model.dart';
import '../core/config/env.dart';

class AuthService {
  final Dio _dio;
  final GetStorage _storage;
  
  // Constructor con inyección de dependencias
  AuthService({Dio? dio, GetStorage? storage}) 
      : _dio = dio ?? Dio(BaseOptions(
          baseUrl: Env.apiUrl,
          headers: {'Content-Type': 'application/json'},
        )),
        _storage = storage ?? GetStorage();

  Future<Map<String, dynamic>> signInWithGoogle(String googleToken) async {
    try {
      final response = await _dio.post(
        '/auth/google/callback',
        data: {'token': googleToken},
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        final user = User.fromJson(response.data['user']);
        
        // Guardar token y datos básicos del usuario
        await _storage.write('token', token);
        await _storage.write('user', response.data['user']);
        
        // Configurar el token para futuras peticiones
        _dio.options.headers['Authorization'] = 'Bearer $token';
        
        return {
          'success': true,
          'user': user,
          'token': token,
        };
      }
      
      return {'success': false, 'message': 'Error de autenticación'};
    } on DioException catch (e) {
      return {
        'success': false, 
        'message': e.response?.data['message'] ?? 'Error de conexión'
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<void> signOut() async {
    await _storage.erase();
    _dio.options.headers.remove('Authorization');
  }

  bool isAuthenticated() {
    final token = getToken();
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      return true;
    }
    return false;
  }

  String? getToken() {
    return _storage.read('token');
  }
}