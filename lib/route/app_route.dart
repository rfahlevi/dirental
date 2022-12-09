import 'package:dirental/auth/login_page.dart';
import 'package:dirental/auth/register_page.dart';
import 'package:dirental/splash_page.dart';
import 'package:get/get.dart';

appRoute() => [
      GetPage(name: '/splash-page', page: () => const SplashPage()),
      GetPage(name: '/register-page', page: () => const RegisterPage()),
      GetPage(name: '/login-page', page: () => const LoginPage()),
    ];
