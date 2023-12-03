class Api {
  Api._();

  static const String PUBLIC_URL = "https://api.local.payrun.app";
  static const String PRIVATE_URL = "https://api.local.payrun.app/graphql";

  static const COMPANY_DOMAIN = "/organization";
  static const LOGIN = "/auth/login";
  static const FORGOT_PASSWORD = "/auth/forgot-password";
  static const RESEND_OTP = "/auth/resend-verification-code";
  static const RESET_PASSWORD = "/auth/verify-forgot-password-code";
}


const getSelectionQuery = """
query GetFromSections {
  getFromSections {
    data {
      name
    }
  }
}
        """;


    const String addStar = r'''
  mutation AddStar($starrableId: ID!) {
    action: addStar(input: {starrableId: $starrableId}) {
      starrable {
        viewerHasStarred
      }
    }
  }
''';
