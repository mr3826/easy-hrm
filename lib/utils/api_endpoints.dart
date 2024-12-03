class Api {
  Api._();

  static const String PUBLIC_URL = String.fromEnvironment("PUBLIC_URL");
  static const CDN_DOMAIN = String.fromEnvironment("CDN_DOMAIN");
  static const CDN_KEY = String.fromEnvironment("CDN_KEY");
  static const String PRIVATE_URL = "$PUBLIC_URL/graphql";
  static const String PUBLIC_IMAGE_URL_DOMAIN =
      String.fromEnvironment("PUBLIC_IMAGE_URL_DOMAIN");
  static const COMPANY_DOMAIN = "/organization";
  static const LOGIN = "/auth/login";
  static const LOGOUT = "/auth/logout";

  static const REFRESH_TOKEN = "/auth/refresh-token";
  static const FORGOT_PASSWORD = "/auth/forgot-password";
  static const RESEND_OTP = "/auth/retry-forgot-password";
  static const RESEND_OTP_CHANGE_EMAIL = "/auth/resend-verification-code";
  static const VERIFY_OTP_CODE = "/auth/verify-forgot-password-code";
  static const RESET_PASSWORD = "/auth/verify-forgot-password";
  static const VERIFY_PASSWORD = "/auth/verify-password";
  static const CHANGE_MAIL = "/auth/change-email";
  static const VERIFY_CHANGE_MAIL_OTP = "/auth/confirm-change-email";
  static const CHANGE_PASSWORD = "/auth/change-password";
  static const USER_INFO = "/auth/user";
}

///auth/resend-verification-code

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

const workShiftQuery = r'''
query GetWorkScheduleForAssignLeave($queryData: WorkSchedulesQueryData!) {
  getWorkScheduleForAssignLeave(queryData: $queryData) {
    id
    day
    day_of_week
    end_time
    is_holiday
    start_time
  }
}
''';
const getUploadPolicyQuery = r'''
query GetUploadPolicy($queryData: UploadPolicyQueryData) {
  getUploadPolicy(queryData: $queryData) {
    url
    policy_data {
      value
      name
    }
  }
}
''';

const getLeaveDetailsByDateQuery = r"""
query GetLeaveRequests($queryData: LeaveRequestQueryType) {
  getLeaveRequests(queryData: $queryData) {
    createdAt
      description
      end_date
      leave_details {
        schedule_seconds
        date
        leave_seconds
      }
      files {
        name
        size
        createdAt
        key
        id
      }
       leaveType {
        type
        id
        name
        add_note_required
        attach_document_required
      }
      status
      number_of_days
      start_date
      id
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
        size
        createdAt
        key
        id
      }
       leave_details {
        schedule_seconds
        date
        leave_seconds
      }
      leave_status
      leaveType {
        type
        id
        name
        add_note_required
        attach_document_required
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
const removeLeaveQuery = r'''
mutation RemoveRejectedLeaves($inputData: DeleteLeaveInputData) {
  removeRejectedLeaves(inputData: $inputData) {
    result
  }
}
''';

const leaveTypeDropdownUpdateQuery = r'''
query GetAvailableLeaveTypes($queryData: AvailableLeaveTypesInput!) {
  getAvailableLeaveTypes(queryData: $queryData) {
    add_note_required
    attach_document_required
    availableLeave
    calculate_allowance_by
    is_default
    is_enable
    leave_type_id
    name
    type
  }
}
''';
// profile module

const getUserProfileQuery = r'''
query GetOrganizationUserDetails($orgUserId: UUID) {
  getOrganizationUserDetails(org_user_id: $orgUserId) {
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
        logo_icon_key
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
    dept_histories {
      department {
        name
        manager {
          profile {
            image
            first_name
            last_name
          }
        }
        parent {
          name
        }
      }
      start_date
      end_date
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
const getOrgSubscriptionInfoQuery = '''
query GetOrgSubscriptionInfo {
  getOrgSubscriptionInfo {
  status
    plan {
      active
      nickname
    }
    subscribed_plan { 
      name
      is_free  
    status
    plan_features {
        id
        is_enabled
        feature {
          id
          identifier
          name
          sub_feature_name
        }
      }}}
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
    id
    end_date
    start_date
    description
    status
    createdAt
    number_of_days
     leave_details {
       schedule_seconds
       date
       leave_seconds
    }
    files {
        name
        size
        createdAt
        key
        id
      }
    leaveType {
        type
        id
        name
        add_note_required
        attach_document_required
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
          logo_icon_key

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
    project_id
  }
}
''';
const removeTimerQueryData = r'''
mutation RemoveTimeline($inputData: RemoveTimelineInputData) {
  removeTimeline(inputData: $inputData) {
    result
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
    id
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
query GetSummaryForTimelines($queryData: SummaryForTimelinesQueryData) {
  getSummaryForTimelines(queryData: $queryData) {
    total_scheduled_seconds
    logged_total_seconds
    total_leaves_seconds
    balance
  }
}
''';

const getTimelogDetailsByMonthQuery = r'''
query GetDailyTimeEntries($queryData: DailyTimeEntriesQueryData, $optionData: OptionDataType) {
  getDailyTimeEntries(queryData: $queryData, optionData: $optionData) {
    data {
      entry_day
      total_scheduled_seconds
      logged_total_seconds
      total_leaves_seconds
      balance
    
    }
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
      files {
        name
        size
        createdAt
        key
        id
      }
      leave_details {
        schedule_seconds
        date
        leave_seconds
      }
      leaveType {
        name
        type
        id
        add_note_required
        attach_document_required
      }
      start_date
      status
      totalLeaveMinutes
      id
      number_of_days
    }
    timelines {
      id
      description
      end_date
      start_date
      status
      task {
        name
        id
      }
      total_minutes
      project {
        id
        name
        color
      }
    }
  }
}
''';

/// notification apis
///

const getUnSeenNotificationQuery = r'''
query GetNotificationActivities($queryData: NotificationActivitiesQueryInputType, $optionData: OptionDataType) {
  getNotificationActivities(queryData: $queryData, optionData: $optionData) {
    data {
      notification {
        id
        createdAt
        context
        changer {
          profile {
            first_name
            last_name
          }
        }
        timeline {
          start_date
        }
        leave {
          start_date
        }
        affectee {
          id
        }
        department {
          name
          manager_id
        }
        job {
          title
          id
        }
      }
    }
    metaData {
      totalRows
      notificationCounts {
        seen_count
        unseen_count
      }
    }
  }
}
''';

const markAsSeenNotificationQuery = r'''
mutation MarkUnreadNotificationAsSeen($inputData: UnreadNotificationSeenInputType!) {
  markUnreadNotificationAsSeen(inputData: $inputData) {
    result
  }
}
''';

/// employyee info
///

const getEmployeeList = r'''
query GetOrganizationUsers($queryData: OrganizationUserQueryData) {
  getOrganizationUsers(queryData: $queryData) {
    data {
      id
      profile {
        first_name
        last_name
        image
      }
      employment_status {
        name
        color
      }
      designation {
        name
      }
      user {
        id
        email
      }
      user_id
    }
  }
}
''';



//Hr_leave


const getHrLeaveCalendarList = r'''
query GET_LEAVES_CALENDAR($queryData: LeaveCalenderInput!, $optionData: OptionDataType) {
  getLeavesCalendar(queryData: $queryData, optionData: $optionData) {
    leave_requests {
      formatted_date
      total_approved
      total_pending
      total_rejected
      total_cancelled
      total_taken
      formatted_leave_hours
    
      organization_users {

        profile {
          first_name
          last_name
          image
          __typename
        }

        roles {
          name
          __typename
        }
          designation {
          description
        }
        id
        leave_id
        __typename
      }
      __typename
    }
    __typename
  }
}
''';



const updateLeaveQuery = r'''
mutation UPDATE_LEAVE($inputData: UpdateLeaveInputData) {
  updateLeave(inputData: $inputData) {
  id
  }
  
}
''';


