class FilterJobsDropdown {
  List<GetJobsDropdown>? getJobsDropdown;

  FilterJobsDropdown({this.getJobsDropdown});

  FilterJobsDropdown.fromJson(Map<String, dynamic> json) {
    if (json['getJobsDropdown'] != null) {
      getJobsDropdown = <GetJobsDropdown>[];
      json['getJobsDropdown'].forEach((v) {
        getJobsDropdown!.add(GetJobsDropdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getJobsDropdown != null) {
      data['getJobsDropdown'] =
          getJobsDropdown!.map((v) => v.toJson()).toList();
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
        ? Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    if (department != null) {
      data['department'] = department!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
