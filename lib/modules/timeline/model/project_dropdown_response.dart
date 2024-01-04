class ProjectDropDownResponse {
  List<GetProjectsDropdown>? getProjectsDropdown;

  ProjectDropDownResponse({this.getProjectsDropdown});

  ProjectDropDownResponse.fromJson(Map<String, dynamic> json) {
    if (json['getProjectsDropdown'] != null) {
      getProjectsDropdown = <GetProjectsDropdown>[];
      json['getProjectsDropdown'].forEach((v) {
        getProjectsDropdown!.add(GetProjectsDropdown.fromJson(v));
      });
    }
  }
}

class GetProjectsDropdown {
  String? color;
  String? name;
  List<Tasks>? tasks;

  GetProjectsDropdown({this.color, this.name, this.tasks});

  GetProjectsDropdown.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    name = json['name'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
  }
}

class Tasks {
  String? name;
  String? taskId;

  Tasks({this.name, this.taskId});

  Tasks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    taskId = json['id'];
  }
}
