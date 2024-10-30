class DepartmentsInfo {
  GetDepartments? getDepartments;

  DepartmentsInfo({this.getDepartments});

  DepartmentsInfo.fromJson(Map<String, dynamic> json) {
    getDepartments = json['getDepartments'] != null
        ? new GetDepartments.fromJson(json['getDepartments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getDepartments != null) {
      data['getDepartments'] = this.getDepartments!.toJson();
    }
    return data;
  }
}

class GetDepartments {
  List<Data>? data;

  GetDepartments({this.data});

  GetDepartments.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;

  Data({this.id, this.name});

  Data.fromJson(Map<String, dynamic> json) {
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
