import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.signOut,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
              'Bienvenido ${controller.userName}',
              style: const TextStyle(fontSize: 20),
            )),
            const SizedBox(height: 20),
            const Text(
              'Esta es la pantalla principal',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}