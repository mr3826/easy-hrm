import 'package:payrun_mobile/modules/auth/presentation/view/sign_in.dart';
import 'package:payrun_mobile/modules/starting/view/onboarding_screen.dart';
import 'package:payrun_mobile/modules/starting/view/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.ONBOARD_SCRREN;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: ()=>const SplashScreen(),
    ),

    GetPage(
      name: _Paths.ONBOARD_SCRREN,
      page: ()=> OnboardScreen(),
    ),
    GetPage(
      name: _Paths.SIGN_IN_SCREEN,
      page: ()=> SignInScreen(),
    ),

  ];
}
