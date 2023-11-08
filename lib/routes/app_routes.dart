part of 'app_pages.dart';

abstract class Routes {
  Routes._();

   static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
   static const ONBOARD_SCRREN = _Paths.ONBOARD_SCRREN;
   static const SIGN_IN_SCREEN = _Paths.SIGN_IN_SCREEN;

}

abstract class _Paths {
  _Paths._();

  static const SPLASH_SCREEN = '/splash-screen';
  static const ONBOARD_SCRREN = '/onboard-screen';
  static const SIGN_IN_SCREEN = '/sign_in-screen';

}
