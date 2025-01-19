class FilterJobsDropdown {
  List<GetJobsDropdown>? getJobsDropdown;

  FilterJobsDropdown({this.getJobsDropdown});

  FilterJobsDropdown.fromJson(Map<String, dynamic> json) {
    if (json['getJobsDropdown'] != null) {
      getJobsDropdown = <GetJobsDropdown>[];
      json['getJobsDropdown'].forEach((v) {
        getJobsDropdown!.add(new GetJobsDropdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getJobsDropdown != null) {
      data['getJobsDropdown'] =
          this.getJobsDropdown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetJobsDropdown {
  String? id;
  String? title;
  String? slug;
  Department? department;

  GetJobsDropdown({this.id, this.title, this.slug, this.department});

  GetJobsDropdown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    return data;
  }
}

class Department {
  String? id;
  String? name;

  Department({this.id, this.name});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
