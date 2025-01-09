// lib/app/modules/auth/controllers/auth_controller.dart
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../services/auth_service.dart';
import '../../../data/models/user_model.dart';

class AuthController extends GetxController {
  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );
  final _authService = AuthService();
  
  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      
      // 1. Intento de inicio de sesión con Google
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw 'Usuario canceló el inicio de sesión';
      }

      // 2. Obtener tokens de autenticación
      final googleAuth = await googleUser.authentication;
      print('Google Auth Token: ${googleAuth.accessToken}'); // Para debug

      // 3. Autenticar con nuestro backend
      final result = await _authService.signInWithGoogle(
        googleAuth.accessToken!,
      );

      if (result['success']) {
        user.value = result['user'];
        Get.offAllNamed('/home');
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Error desconocido',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      print('Error detallado: $error'); // Para debug
      Get.snackbar(
        'Error de autenticación',
        'Detalles: ${error.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _authService.signOut();
      user.value = null;
      Get.offAllNamed('/auth');
    } catch (error) {
      print('Error en signOut: $error');
      Get.snackbar(
        'Error',
        'No se pudo cerrar sesión correctamente',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}