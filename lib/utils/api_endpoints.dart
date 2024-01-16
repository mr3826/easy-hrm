class Api {
  Api._();

  static const String PUBLIC_URL = "https://api.local.payrun.app";
  static const String PRIVATE_URL = "$PUBLIC_URL/graphql";
  static const String PUBLIC_IMAGE_URL_DOMAIN =
      "https://local-payrun-files.s3.amazonaws.com";

  static const COMPANY_DOMAIN = "/organization";
  static const LOGIN = "/auth/login";
  static const LOGOUT = "/auth/logout";
  static const REFRESH_TOKEN = "/auth/refresh-token";
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
      description
      end_date
      files {
        name
      }
      leave_status
      leaveType {
        type
        id
        name
      }
      status
      number_of_days
      start_date
      id
    }
  }
}
        """;

const getLeaveRecordsDataQuery = r'''
query GetLeaveRecordsForApp($optionData: OptionDataType) {
  getLeaveRecordsForApp(optionData: $optionData) {
    date
    data {
      createdAt
      description
      end_date
      files {
        name
      }
      leave_status
      leaveType {
        type
        id
        name
      }
      status
      number_of_days
      start_date
      id
    }
  }
}
''';

const assignLeaveQuery = r'''
mutation AssignLeave($inputData: CreateLeaveInputData) {
  assignLeave(inputData: $inputData) {
    id
  }
}
''';

const cancelLeaveQuery = r'''
mutation UpdateLeave($inputData: UpdateLeaveInputData) {
  updateLeave(inputData: $inputData) {
    id
  }
}
''';

const leaveTypeDropdownQuery = '''
query GetLeaveTypesDropdown {
  getLeaveTypesDropdown {
    name
    id
    attach_document_required
    add_note_required
    leave_statuses {
      available_number_of_days
    }
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
        logo_key
        language
      }
      name
      id
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

const upcommingLeaveForDashboardQuery = '''
query GetUpcomingLeavesForApp {
  getUpcomingLeavesForApp {
    end_date
    start_date
    description
    status
    createdAt
    number_of_days
    leaveType {
      type
      id
      name
    }
  }
}
''';

const organizationInfoQuery = '''
query GetUserOrganizations {
  getUserOrganizations {
    data {
      organization {
        name
        id
        sub_domain
        organization_setting {
          logo_key
        }
      }
      designation {
        description
        name
      }
    }
  }
}
''';

// timeline

const startOrEndTimerQueryData = r'''
mutation StartOrStopTimer($inputData: StartOrStopTimerInputData) {
  startOrStopTimer(inputData: $inputData) {
    id
    end_date
    start_date
  }
}
''';

const saveTimerQueryData = r'''
mutation UpdateTimelineEntry($inputData: UpdateTimelineInputData) {
  updateTimelineEntry(inputData: $inputData) {
    description
    end_date
    start_date
    status
    task_id
  }
}
''';

const updateTimelineLogDetailsQueryData = r'''
mutation UpdateTimelineEntry($inputData: UpdateTimelineInputData) {
  updateTimelineEntry(inputData: $inputData) {
    id
  }
}
''';

const getProjectDropdownQuery = r'''
query GetProjectsDropdown($queryData: ProjectQueryInputType, $optionData: OptionDataType) {
  getProjectsDropdown(queryData: $queryData, optionData: $optionData) {
    color
    name
    tasks {
      id
      name
    }
  }
}
''';
const createNewEntryQuery = r'''
mutation CreateTimelineEntry($inputData: CreateTimelineEntryInputData) {
  createTimelineEntry(inputData: $inputData) {
    id
    end_date
    start_date
    description
    status
    task_id
  }
}
''';

const timerStatusQuery = '''
query CheckStartOrStopTimeline {
  checkStartOrStopTimeline {
    start_date
  }
}
''';

const getTimelineSummaryByDateQuery = r'''
query GetTimelogSummaryForApp($queryData: TimelogQueryInputType!) {
  getTimelogSummaryForApp(queryData: $queryData) {
    total_schedule
    total_logged
    paid_leave
    balanced
  }
}
''';

const getTimelogDetailsByMonthQuery = r'''
query GetTimelogsForApp($queryData: TimelineEntriesQueryData) {
  getTimelogsForApp(queryData: $queryData) {
    balance
    date
    leave
    logged
    schedule
    day
  }
}
''';

const getCalendarTimelineQuery = r'''
query GetCalenderTimelinesForApp($queryData: CalenderTimelinesForAppQueryData) {
  getCalenderTimelinesForApp(queryData: $queryData) {
    leaves {
      createdAt
      description
      end_date
      leaveType {
        name
        type
        id
      }
      start_date
      status
      totalLeaveMinutes
    }
    timelines {
      description
      end_date
      start_date
      status
      task {
        name
        id
        project {
          id
          name
        }
      }
      total_minutes
      task_id
      id
      project_id
    }
  }
}
''';
