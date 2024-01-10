


class LastInput{
  String? email;
  String? password;
  String? orgName;

  LastInput({this.email, this.password, this.orgName});

  LastInput.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    orgName = json['org_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['org_name'] = orgName;
    return data;
  }
}



class ModelForDescription{

  String? status;
  String? description;
  ModelForDescription({this.status, this.description});

  ModelForDescription.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['description'] = description;
    return data;
  }
}