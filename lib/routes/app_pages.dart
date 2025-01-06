import 'package:get/get.dart';
import 'package:hay_futbol_app/modules/auth/views/auth_view.dart';
import 'package:hay_futbol_app/modules/home/bindings/home_binding.dart';
import 'package:hay_futbol_app/modules/home/views/home_view.dart';

// Bindings
//import '../modules/auth/bindings/auth_binding.dart';
//import '../modules/splash/bindings/splash_binding.dart';

// Views
//import '../modules/splash/views/splash_view.dart';
//import '../modules/auth/views/login_view.dart';
//import '../modules/auth/views/register_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
   GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}