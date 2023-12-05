part of 'app_pages.dart';

abstract class Routes {
  Routes._();

   static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
   static const ONBOARD_SCRREN = _Paths.ONBOARD_SCRREN;
   static const SIGN_IN_SCREEN = _Paths.SIGN_IN_SCREEN;
   static const FIRGIR_PASSWORD_SCREEN = _Paths.FIRGIR_PASSWORD_SCREEN;
   static const OTP = _Paths.OTP;
   static const RESET_PASSWORD = _Paths.RESET_PASSWORD;
   static const PASSWORD_UPDATE_SCRREN = _Paths.PASSWORD_UPDATE_SCRREN;
   static const MAIN_SCREEN = _Paths.MAIN_SCREEN;
   static const LEAVE_SCREEN = _Paths.LEAVE_SCREEN;
   static const LEAVE_RECORD_SCREEN = _Paths.LEAVE_RECORD_SCREEN;
   static const NOTIFICATION_SCREEN = _Paths.NOTIFICATION_SCREEN;
   static const PROFILE_SCREEN = _Paths.PROFILE_SCREEN;
   static const EDIT_PROFILE_SCREEN = _Paths.EDIT_PROFILE_SCREEN;
   static const TIME_LOG_SUMMARY = _Paths.TIME_LOG_SUMMARY;
   static const NEW_ENTRY_SCREEN = _Paths.NEW_ENTRY_SCREEN;

}

abstract class _Paths {
  _Paths._();

  static const SPLASH_SCREEN = '/splash-screen';
  static const ONBOARD_SCRREN = '/onboard-screen';
  static const SIGN_IN_SCREEN = '/sign_in-screen';
  static const FIRGIR_PASSWORD_SCREEN = '/forgot_password-screen';
  static const OTP = '/otp-screen';
  static const RESET_PASSWORD = '/reset_password-screen';
  static const PASSWORD_UPDATE_SCRREN = '/password_update-screen';
  static const MAIN_SCREEN = '/main-screen';
  static const LEAVE_SCREEN = '/leave-screen';
  static const LEAVE_RECORD_SCREEN = '/leave_record-screen';
  static const NOTIFICATION_SCREEN = '/notification-screen';
  static const PROFILE_SCREEN = '/profile-screen';
  static const EDIT_PROFILE_SCREEN = '/edit_profile-screen';
  static const TIME_LOG_SUMMARY = '/time_log_summary-screen';
  static const NEW_ENTRY_SCREEN = '/new_entry-screen';

}
