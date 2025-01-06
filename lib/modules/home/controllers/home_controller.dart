import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends GetxController {
  final _googleSignIn = GoogleSignIn();
  final userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await _googleSignIn.signInSilently();
    if (user != null) {
      userName.value = user.displayName ?? 'Usuario';
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      Get.offAllNamed('/auth');
    } catch (error) {
      Get.snackbar(
        'Error',
        'No se pudo cerrar sesión',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}