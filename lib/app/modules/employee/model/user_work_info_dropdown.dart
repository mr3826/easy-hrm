// Base Class for common properties
class DropdownItem {
  final String id;
  final String name;

  DropdownItem({
    required this.id,
    required this.name,
  });

  factory DropdownItem.fromJson(Map<String, dynamic> json) {
    return DropdownItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

// Extended class for EmploymentStatus
class EmploymentStatus extends DropdownItem {
  final String color;

  EmploymentStatus({
    required String id,
    required String name,
    required this.color,
  }) : super(id: id, name: name);

  factory EmploymentStatus.fromJson(Map<String, dynamic> json) {
    return EmploymentStatus(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      color: json['color'] ?? '#FFFFFF', // Default to white if color is missing
    );
  }
}

// Parsing classes
class EmploymentStatusList {
  final List<EmploymentStatus> statuses;

  EmploymentStatusList({required this.statuses});

  factory EmploymentStatusList.fromJson(Map<String, dynamic>? json) {
    return EmploymentStatusList(
      statuses: (json?['getEmploymentStatusesDropdown'] as List<dynamic>? ?? [])
          .map((item) => EmploymentStatus.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DepartmentList {
  final List<DropdownItem> departments;

  DepartmentList({required this.departments});

  factory DepartmentList.fromJson(Map<String, dynamic>? json) {
    return DepartmentList(
      departments: (json?['getDepartmentsDropdown'] as List<dynamic>? ?? [])
          .map((item) => DropdownItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DesignationList {
  final List<DropdownItem> designations;

  DesignationList({required this.designations});

  factory DesignationList.fromJson(Map<String, dynamic>? json) {
    return DesignationList(
      designations: (json?['getDesignationsDropdown'] as List<dynamic>? ?? [])
          .map((item) => DropdownItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
