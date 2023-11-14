class Api{
  Api._();
  static const String PUBLIC_URL = "https://api.local.payrun.app";

  static const COMPANY_DOMAIN="/organization";
  static const LOGIN="/auth/login";
  static const FORGOT_PASSWORD="/auth/forgot-password";
  static const RESEND_OTP="/auth/resend-verification-code";
  static const RESET_PASSWORD="/auth/verify-forgot-password-code";
}
