import 'package:billcull/pages/home.dart';
import 'package:billcull/pages/login.dart';
import 'package:billcull/pages/register.dart';
import 'package:get/get.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.HOME,
        page: () => const HomePage(),
        transition: Transition.circularReveal),
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginPage(),
        transition: Transition.circularReveal),
    GetPage(
        name: Routes.REGISTER,
        page: () => RegisterPage(),
        transition: Transition.circularReveal),
  ];
}
