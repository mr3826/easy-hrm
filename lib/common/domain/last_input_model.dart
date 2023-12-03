


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