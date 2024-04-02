class OrgSubscriptionInfoModel {
  GetOrgSubscriptionInfo? getOrgSubscriptionInfo;

  OrgSubscriptionInfoModel({this.getOrgSubscriptionInfo});

  OrgSubscriptionInfoModel.fromJson(Map<String, dynamic> json) {
    getOrgSubscriptionInfo = json['getOrgSubscriptionInfo'] != null
        ? GetOrgSubscriptionInfo.fromJson(json['getOrgSubscriptionInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (getOrgSubscriptionInfo != null) {
      data['getOrgSubscriptionInfo'] = this.getOrgSubscriptionInfo!.toJson();
    }
    return data;
  }
}

class GetOrgSubscriptionInfo {
  String? status;

  @override
  String toString() {
    return 'GetOrgSubscriptionInfo{status: $status}';
  }

  GetOrgSubscriptionInfo({this.status});

  GetOrgSubscriptionInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}
