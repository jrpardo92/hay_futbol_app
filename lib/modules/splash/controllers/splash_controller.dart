import 'dart:io';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashController extends GetxController {
  final _googleSignIn = GoogleSignIn();
  
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    validateInitialConfig();
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> validateInitialConfig() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      // Verificar conexión a internet
      final hasConnection = await checkInternetConnection();
      if (!hasConnection) {
        throw 'No hay conexión a internet';
      }

      // Verificar sesión de Google
      final isSignedIn = await _googleSignIn.isSignedIn();
      
      // Delay para mostrar el splash
      await Future.delayed(const Duration(seconds: 2));

      if (isSignedIn) {
        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/auth');
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void retryValidation() {
    validateInitialConfig();
  }
}