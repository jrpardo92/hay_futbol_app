import 'dart:io';
import 'package:get/get.dart';

class SplashController extends GetxController {
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

      // Simulamos una pequeña carga
      await Future.delayed(const Duration(seconds: 2));
      
      // Por ahora, siempre vamos al auth
      Get.offAllNamed('/auth');
      
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