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
            onPressed: () => Get.offAllNamed('/auth'),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Bienvenido a la App de Fútbol',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}