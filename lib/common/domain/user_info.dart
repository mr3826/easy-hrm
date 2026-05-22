class UserInfo {
  String? message;
  User? user;

  UserInfo({this.message, this.user});

  UserInfo.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
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
  dynamic topDeptHeadLevel;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roles'] = roles;
    data['userId'] = userId;
    data['userStatus'] = userStatus;
    data['userEmail'] = userEmail;
    data['orgUserId'] = orgUserId;
    data['organizationId'] = organizationId;
    data['isRootDeptHead'] = isRootDeptHead;
    data['topDeptHeadLevel'] = topDeptHeadLevel;
    data['role'] = role;
    return data;
  }
}
