class EmploymentsStatus {
  List<GetEmploymentsStatus>? getEmploymentsStatus;

  EmploymentsStatus({this.getEmploymentsStatus});

  EmploymentsStatus.fromJson(Map<String, dynamic> json) {
    if (json['getEmploymentsStatus'] != null) {
      getEmploymentsStatus = <GetEmploymentsStatus>[];
      json['getEmploymentsStatus'].forEach((v) {
        getEmploymentsStatus!.add(new GetEmploymentsStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getEmploymentsStatus != null) {
      data['getEmploymentsStatus'] =
          this.getEmploymentsStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetEmploymentsStatus {
  String? id;
  String? name;

  GetEmploymentsStatus({this.id, this.name});

  GetEmploymentsStatus.fromJson(Map<String, dynamic> json) {
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
