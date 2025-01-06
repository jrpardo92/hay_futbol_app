import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo o imagen de splash
              FlutterLogo(size: 100),
              const SizedBox(height: 30),
              
              if (controller.isLoading.value)
                const CircularProgressIndicator()
              else if (controller.hasError.value)
                Column(
                  children: [
                    Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                    ElevatedButton(
                      onPressed: controller.retryValidation,
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}