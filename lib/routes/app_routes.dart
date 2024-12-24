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
  static const TIMER_SCREEN = _Paths.TIMER_SCREEN;
  static const HOME_SCREEN = _Paths.HOME_SCREEN;
  static const SUBSCRIPTION_SCREEN = _Paths.SUBSCRIPTION_SCREEN;
  static const EMPOLYEE_VIEW_PROFILE = _Paths.EMPOLYEE_VIEW_PROFILE;
  static const EDIT_EMPOLYEE_VIEW = _Paths.EDIT_EMPOLYEE_VIEW;
  static const ALL_CANDIDATES = _Paths.ALL_CANDIDATES;
  static const EDIT_CANDIDATES = _Paths.EDIT_CANDIDATES;
}

abstract class _Paths {
  _Paths._();

  static const SPLASH_SCREEN = '/splash_screen';
  static const ONBOARD_SCRREN = '/onboard_screen';
  static const SIGN_IN_SCREEN = '/sign_in-screen';
  static const FIRGIR_PASSWORD_SCREEN = '/forgot_password_screen';
  static const OTP = '/otp_screen';
  static const RESET_PASSWORD = '/reset_password_screen';
  static const PASSWORD_UPDATE_SCRREN = '/password_update_screen';
  static const MAIN_SCREEN = '/main_screen';
  static const LEAVE_SCREEN = '/leave_screen';
  static const LEAVE_RECORD_SCREEN = '/leave_record_screen';
  static const NOTIFICATION_SCREEN = '/notification_screen';
  static const PROFILE_SCREEN = '/profile_screen';
  static const EDIT_PROFILE_SCREEN = '/edit_profile_screen';
  static const TIME_LOG_SUMMARY = '/time_log_summary_screen';
  static const NEW_ENTRY_SCREEN = '/new_entry_screen';
  static const TIMER_SCREEN = '/timer_screen';
  static const HOME_SCREEN = '/home_screen';
  static const SUBSCRIPTION_SCREEN = '/subscription_screen';
  static const EMPOLYEE_VIEW_PROFILE = '/employee_view_profile_screen';
  static const EDIT_EMPOLYEE_VIEW = '/edit_employee_view_screen';
  static const ALL_CANDIDATES = '/all_candidates_view_screen';
  static const EDIT_CANDIDATES = '/edit_candidates_screen';
}
