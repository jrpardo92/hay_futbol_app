import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

// Importaciones de rutas (las crearemos después)
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Forzar orientación vertical
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fútbol App',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      initialBinding: InitialBinding(), // Lo crearemos después
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoutes.INITIAL, // Ruta inicial (auth/splash)
      getPages: AppPages.pages, // Definiremos las rutas después
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('es', 'ES'),
    );
  }
}