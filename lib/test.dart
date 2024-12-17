
const getUserProfileQuery = r'''
query GetOrganizationUsers($queryData: OrganizationUserQueryData, $optionData: OptionDataType) {
  getOrganizationUsers(queryData: $queryData, optionData: $optionData) {
    data {
      id
      join_date
      employee_id
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
