class OrgSubscriptionInfoModel {
  GetAnOrganizationSubscription? getAnOrganizationSubscription;

  OrgSubscriptionInfoModel({this.getAnOrganizationSubscription});

  OrgSubscriptionInfoModel.fromJson(Map<String, dynamic> json) {
    getAnOrganizationSubscription =
    json['getAnOrganizationSubscription'] != null
        ? new GetAnOrganizationSubscription.fromJson(
        json['getAnOrganizationSubscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getAnOrganizationSubscription != null) {
      data['getAnOrganizationSubscription'] =
          this.getAnOrganizationSubscription!.toJson();
    }
    return data;
  }
}

class GetAnOrganizationSubscription {
  String? status;
  Plan? plan;

  GetAnOrganizationSubscription({this.status, this.plan});

  GetAnOrganizationSubscription.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    return data;
  }
}

class Plan {
  List<PlanFeatures>? planFeatures;

  Plan({this.planFeatures});

  Plan.fromJson(Map<String, dynamic> json) {
    if (json['plan_features'] != null) {
      planFeatures = <PlanFeatures>[];
      json['plan_features'].forEach((v) {
        planFeatures!.add(new PlanFeatures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.planFeatures != null) {
      data['plan_features'] =
          this.planFeatures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanFeatures {
  Feature? feature;
  bool? isEnabled;

  PlanFeatures({this.feature, this.isEnabled});

  PlanFeatures.fromJson(Map<String, dynamic> json) {
    feature =
    json['feature'] != null ? new Feature.fromJson(json['feature']) : null;
    isEnabled = json['is_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feature != null) {
      data['feature'] = this.feature!.toJson();
    }
    data['is_enabled'] = this.isEnabled;
    return data;
  }
}

class Feature {
  String? identifier;
  String? name;

  Feature({this.identifier, this.name});

  Feature.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['name'] = this.name;
    return data;
  }
}
