import 'package:payrun_mobile/modules/starting/view/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH_SCREEN;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: ()=>const SplashScreen(),
    ),

  ];
}
