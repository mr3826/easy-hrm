class Api {
  Api._();

  static const String PUBLIC_URL = "https://api.local.payrun.app";
  static const String PRIVATE_URL = "$PUBLIC_URL/graphql";
  static const String PUBLIC_IMAGE_URL_DOMAIN =
      "https://local-payrun-files.s3.amazonaws.com";

  static const COMPANY_DOMAIN = "/organization";
  static const LOGIN = "/auth/login";
  static const FORGOT_PASSWORD = "/auth/forgot-password";
  static const RESEND_OTP = "/auth/resend-verification-code";
  static const RESET_PASSWORD = "/auth/verify-forgot-password-code";
  static const VERIFY_PASSWORD = "/auth/verify-password";
  static const CHANGE_MAIL = "/auth/change-email";
  static const VERIFY_CHANGE_MAIL_OTP = "/auth/confirm-change-email";
  static const CHANGE_PASSWORD = "/auth/change-password";
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

// profile module

const getUserProfileQuery = '''
query GetOrganizationUserDetails {
  getOrganizationUserDetails {
    profile {
      id
      about
      address
      emergency_number
      first_name
      image
      last_name
      personal_number
    }
    user {
      email
      id
    }
   
    department {
      name
      id
      parent {
        id
        name
      }
      work_shift {
        name
        work_schedules {
          day
          end_time
          start_time
          is_holiday
        }
      }
    }
    status
    organization {
      organization_setting {
        language
        logo_key
      }
      name
    }
  }
}
''';

const getEmploymentInfoQuery = r'''
query GET_ORGANIZATION_USER_HISTORY($orgUserId: UUID) {
  getOrganizationUserHistory(org_user_id: $orgUserId) {
    designation_histories {
      start_date
      end_date
      designation {
        id
        name
      }
    }
    employment_histories {
      start_date
      end_date
      employment_status {
        name
        color
        id
      }
    }
  }
 
}
''';

const userLogHistoryQuery = '''
query GeTimelogAndLeaveAvailabilityForApp {
  geTimelogAndLeaveAvailabilityForApp {
    total_logged
    total_schedule
    balance_leave
  }
}
''';

const updateUserProfileMutation = r'''
mutation UpdateOrganizationUser($inputData: UpdateOrganizationUserInputData!) {
  updateOrganizationUser(inputData: $inputData) {
    id
  }
}
''';


//dashboard

const profileInfoForDashboardQuery = '''
query GetProfileSummaryForDashboard {
  getProfileSummaryForDashboard {
    org_user_id
    profile {
      first_name
      image
    }
    total_schedule
    total_logged
    progress_percentage
  }
}
''';

const timelineSummaryInfoDashboardQuery = '''
query GetMonthlyTimelog {
  getMonthlyTimelog {
    progress_percentage
    total_schedule
    total_logged
  }
}
''';


const upcommingLeaveForDashboardQuery='''
query GetUpcomingLeavesForApp {
  getUpcomingLeavesForApp {
    end_date
    start_date
    status
    createdAt
    number_of_days
    leaveType {
      type
    }
  }
}
''';

const organizationInfoQuery='''
query GetUserOrganizations {
  getUserOrganizations {
    data {
      organization {
        name
        id
        organization_setting {
          logo_key
        }
      }
    }
  }
}
''';
