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
  String? projectId;
  String? name;
  List<Tasks>? tasks;

  GetProjectsDropdown({this.color, this.name, this.tasks,this.projectId});

  GetProjectsDropdown.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    projectId = json['id'];
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
