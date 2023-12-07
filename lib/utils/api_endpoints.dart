class Api {
  Api._();

  static const String PUBLIC_URL = "https://api.local.payrun.app";
  static const String PRIVATE_URL = "$PUBLIC_URL/graphql";

  static const COMPANY_DOMAIN = "/organization";
  static const LOGIN = "/auth/login";
  static const FORGOT_PASSWORD = "/auth/forgot-password";
  static const RESEND_OTP = "/auth/resend-verification-code";
  static const RESET_PASSWORD = "/auth/verify-forgot-password-code";
}

//leave module
const getLeaveSummaryForDashboardQuery = """
query Query {
  getLeaveSummaryForDashboard {
    total_leave_day
    taken_leave
    balance_leave
    
  }
}
        """;

const getLeaveDetailsByDateQuery = r"""
query GetLeaveDetailsByDate($queryData: CommonDateRangeInput!) {
  getLeaveDetailsByDate(queryData: $queryData) {
    leave_requests {
      createdAt
      status
      duration
      leaveType {
        type
      }
      leave_status
      end_date
      start_date
    }
  }
}
        """;

const getLeaveRecordsQuery = r'''

query GetLeaveRecords($queryData: LeaveRecordsQueryInput) {
  getLeaveRecords(queryData: $queryData) {
    end_date
    start_date
    id
    createdAt
    leaveType {
      type
    }
    duration
    files {
      name
      id
    }
    status
  }
}

''';
