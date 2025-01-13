class Api {
  static final Api _instance = Api._internal();

  factory Api() => _instance;

  Api._internal();

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
query GetLeaveRecordsForApp($queryData: LeaveRecordsQueryInput, $optionData: OptionDataType) {
  getLeaveRecordsForApp(queryData: $queryData, optionData: $optionData) {
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

const updatedLeaveQuery = r'''
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
    join_date
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
        id
        name
        color
      }
    }
    
    dept_histories {
      start_date
      end_date
      department {
        id
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
    }
  }
}
''';

const userLogHistoryQuery = r'''
query GeTimelogAndLeaveAvailabilityForApp($orgUserId: UUID) {
  geTimelogAndLeaveAvailabilityForApp(org_user_id: $orgUserId) {
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

const getOrgSubscriptionInfoQuery = r'''
query GetAnOrganizationSubscription {
  getAnOrganizationSubscription {
    status
    plan {
      id
      plan_features {
        is_enabled
        feature {
          id
          identifier
        }
      }
    }
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
query GetSummaryForTimelines($queryData: TimelinesQueryDataInputType) {
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

/// employee info
///

const getEmployeeList = r'''
query GetOrganizationUsers($queryData: OrganizationUserQueryData, $optionData: OptionDataType) {
  getOrganizationUsers(queryData: $queryData, optionData: $optionData) {
    data {
      id
      join_date
      profile {
        first_name
        last_name
        image
      }
      employment_status {
        id
        name
        color
      }
      designation {
        id
        name
      }
      department {
        id
        name
      }
      user {
        id
        email
      }
      user_id
      
    }
    metaData {
      filteredRows
    }
  }
}
''';

const getDepartmentInfo = '''
query GetDepartmentsDropdown {
  getDepartmentsDropdown {
    id
    name
  }
}
''';

const getEmploymentStatusInfo = '''
query GetEmploymentStatusesDropdown {
  getEmploymentStatusesDropdown {
    id
    name
    color
  }
}
''';

const getEmploymentDesignationInfo = '''
query GetDesignationsDropdown {
  getDesignationsDropdown {
    id
    name
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
      leave_type_name
      leave_type_category
      organization_users {
        profile {
          first_name
          last_name
          image
        }
        roles {
          name
        }
        designation {
          description
        }
        leave_id
      }
    }
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

const getFileSignUrlQuery = r'''
query GET_FILE_SIGNED_URL($fileKey: String!, $isDownload: Boolean) {
   getFileSignedUrl(fileKey: $fileKey, isDownload: $isDownload)
    }
''';
const getAvailableLeavesTypeQuery = r'''
query GET_AVAILABLE_LEAVES_TYPES($queryData: AvailableLeaveTypesInput!, $optionData: OptionDataType) {
  getAvailableLeaveTypes(queryData: $queryData, optionData: $optionData) {
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

const addAssignLeaveQuery = r'''
mutation ASSIGN_LEAVE($inputData: CreateLeaveInputData) {
  assignLeave(inputData: $inputData) {
    id
    leaveType {
      id
      name
      type
    }
  }
}
''';

const getHrLeaveRecordeQuery = r'''
query GET_LEAVE_REQUESTS($queryData: LeaveRequestQueryType, $optionData: OptionDataType) {
  getLeaveRequests(queryData: $queryData, optionData: $optionData) {
    id
    start_date
    end_date
    description
    status
    leaveType {
      id
      name
      type
      number_of_days
      number_of_applications
      application_date
     
    }
    leave_details {
      leave_id
      leave_seconds
    }
    files {
      id
      name
      size
      key
    }
    organization_user {
      designation {
        name
      }
      status
      profile {
        id
        first_name
        last_name
        image
  
      }
      department {
        id
        name
      }
    }
  }
}
''';

const getLeaveDetailsByIdQuery = r'''
query GET_LEAVE_DETAILS_BY_ID($queryData: LeaveDetailsInput!) {
  getLeaveDetailsById(queryData: $queryData) {
    id
    createdAt
    type
    description
    total_duration
    totalLeaveMinutes
    status
    start_date
    organization_user {
      id
      profile {
        user_id
        last_name
        image
        id
        first_name
      }
      roles {
        name
      }
      designation {
        name
      }
    }
    leaveType {
      id
      name
      type
      calculate_allowance_by
    }
    leave_details {
    id
    leave_id
      date
      leave_seconds
      schedule_seconds
    }
    duration
    end_date
    files {
      name
      key
      id
      size
    }
    number_of_days
  }
}
''';

//'hr dashboard'

const getEmployeeOverviewQuery = r'''
query GET_EMPLOYEE_OVERVIEW {
getEmployeeOverview {
working_today
on_leave_today
not_working_today
}
}
''';

const getJobOpeningQuery = r'''
query GET_JOBS($queryData: JobsQueryInputType, $optionData: OptionDataType) {
  getJobs(queryData: $queryData, optionData: $optionData) {
    data {
      id
      title
      status
      last_date_of_apply
      location
      no_of_vacancy
      thumbnail
      type
      hiring_stages {
        title
        no_of_applicant
      }
    }
 
  }
}
''';

const getLeaveAndTimeLogQuery = r'''
query GET_LEAVE_AND_TIMELOG_REQUEST_SUMMARY {
getLeaveAndTimelogRequestSummary {
total_candidates
leave_request
timelog_request
  }
}
''';

const getJobApplicationBoardQuery = r'''
query GetJobApplicationBoard($optionData: OptionDataType, $queryData: JobApplicationBoardQueryType!) {
  getJobApplicationBoard(optionData: $optionData, queryData: $queryData) {
    id
    title
    type
    last_date_of_apply
    location
    status
    department {
      name
    }
    hiring_stages {
      id
      title
      priority
      no_of_applicant
      job_applications {
        id
        priority
        candidate {
          id
          first_name
          last_name
           email
          avatar_key
        }
      }
    }
  }
}
''';
