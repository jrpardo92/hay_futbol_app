import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final result = await _googleSignIn.signIn();
      if (result != null) {
        Get.offAllNamed('/home');
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'No se pudo iniciar sesión con Google',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}