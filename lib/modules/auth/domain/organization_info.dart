class OrganizationInfo {
  bool? success;
  String? message;
  Data? data;

  OrganizationInfo({this.success, this.message, this.data});

  OrganizationInfo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? id;
  String? name;
  String? subDomain;

  Data({this.id, this.name, this.subDomain});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subDomain = json['sub_domain'];
  }
}
