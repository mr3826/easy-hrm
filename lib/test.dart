
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
    employee_id
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