class UserInfo {
  String? message;
  User? user;

  UserInfo({this.message, this.user});

  UserInfo.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  List<String>? roles;
  String? userId;
  String? userStatus;
  String? userEmail;
  String? orgUserId;
  String? organizationId;
  bool? isRootDeptHead;
  int? topDeptHeadLevel;
  List<String>? role;

  User(
      {this.roles,
        this.userId,
        this.userStatus,
        this.userEmail,
        this.orgUserId,
        this.organizationId,
        this.isRootDeptHead,
        this.topDeptHeadLevel,
        this.role});

  User.fromJson(Map<String, dynamic> json) {
    roles = json['roles'].cast<String>();
    userId = json['userId'];
    userStatus = json['userStatus'];
    userEmail = json['userEmail'];
    orgUserId = json['orgUserId'];
    organizationId = json['organizationId'];
    isRootDeptHead = json['isRootDeptHead'];
    topDeptHeadLevel = json['topDeptHeadLevel'];
    role = json['role'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roles'] = this.roles;
    data['userId'] = this.userId;
    data['userStatus'] = this.userStatus;
    data['userEmail'] = this.userEmail;
    data['orgUserId'] = this.orgUserId;
    data['organizationId'] = this.organizationId;
    data['isRootDeptHead'] = this.isRootDeptHead;
    data['topDeptHeadLevel'] = this.topDeptHeadLevel;
    data['role'] = this.role;
    return data;
  }
}
