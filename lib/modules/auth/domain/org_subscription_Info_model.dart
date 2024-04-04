class OrgSubscriptionInfoModel {
  GetOrgSubscriptionInfo? getOrgSubscriptionInfo;

  OrgSubscriptionInfoModel({this.getOrgSubscriptionInfo});

  OrgSubscriptionInfoModel.fromJson(Map<String, dynamic> json) {
    getOrgSubscriptionInfo = json['getOrgSubscriptionInfo'] != null
        ? new GetOrgSubscriptionInfo.fromJson(json['getOrgSubscriptionInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getOrgSubscriptionInfo != null) {
      data['getOrgSubscriptionInfo'] = this.getOrgSubscriptionInfo!.toJson();
    }
    return data;
  }
}

class GetOrgSubscriptionInfo {
  Plan? plan;
  SubscribedPlan? subscribedPlan;

  GetOrgSubscriptionInfo({this.plan, this.subscribedPlan});

  GetOrgSubscriptionInfo.fromJson(Map<String, dynamic> json) {
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    subscribedPlan = json['subscribed_plan'] != null
        ? new SubscribedPlan.fromJson(json['subscribed_plan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    if (this.subscribedPlan != null) {
      data['subscribed_plan'] = this.subscribedPlan!.toJson();
    }
    return data;
  }
}

class Plan {
  bool? active;
  String? nickname;

  Plan({this.active, this.nickname});

  Plan.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['nickname'] = this.nickname;
    return data;
  }
}

class SubscribedPlan {
  String? name;
  bool? isFree;
  String? status;
  List<PlanFeatures>? planFeatures;

  SubscribedPlan({this.name, this.isFree, this.status, this.planFeatures});

  SubscribedPlan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isFree = json['is_free'];
    status = json['status'];
    if (json['plan_features'] != null) {
      planFeatures = <PlanFeatures>[];
      json['plan_features'].forEach((v) {
        planFeatures!.add(new PlanFeatures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['is_free'] = this.isFree;
    data['status'] = this.status;
    if (this.planFeatures != null) {
      data['plan_features'] =
          this.planFeatures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanFeatures {
  String? id;
  Feature? feature;

  PlanFeatures({this.id, this.feature});

  PlanFeatures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feature =
    json['feature'] != null ? new Feature.fromJson(json['feature']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.feature != null) {
      data['feature'] = this.feature!.toJson();
    }
    return data;
  }
}

class Feature {
  String? id;
  String? identifier;
  String? name;
  String? subFeatureName;

  Feature({this.id, this.identifier, this.name, this.subFeatureName});

  Feature.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    identifier = json['identifier'];
    name = json['name'];
    subFeatureName = json['sub_feature_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['identifier'] = this.identifier;
    data['name'] = this.name;
    data['sub_feature_name'] = this.subFeatureName;
    return data;
  }
}
