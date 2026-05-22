class OrgSubscriptionInfoModel {
  GetAnOrganizationSubscription? getAnOrganizationSubscription;

  OrgSubscriptionInfoModel({this.getAnOrganizationSubscription});

  OrgSubscriptionInfoModel.fromJson(Map<String, dynamic> json) {
    getAnOrganizationSubscription =
    json['getAnOrganizationSubscription'] != null
        ? GetAnOrganizationSubscription.fromJson(
        json['getAnOrganizationSubscription'])
        : null;
  }

  @override
  String toString() {
    return 'OrgSubscriptionInfoModel{getAnOrganizationSubscription: $getAnOrganizationSubscription}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getAnOrganizationSubscription != null) {
      data['getAnOrganizationSubscription'] =
          getAnOrganizationSubscription!.toJson();
    }
    return data;
  }

}

class GetAnOrganizationSubscription {
  String? status;
  Plan? plan;


  @override
  String toString() {
    return 'GetAnOrganizationSubscription{status: $status, plan: $plan}';
  }

  GetAnOrganizationSubscription({this.status, this.plan});

  GetAnOrganizationSubscription.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (plan != null) {
      data['plan'] = plan!.toJson();
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
        planFeatures!.add(PlanFeatures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (planFeatures != null) {
      data['plan_features'] =
          planFeatures!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Plan{planFeatures: $planFeatures}';
  }
}

class PlanFeatures {
  Feature? feature;
  bool? isEnabled;


  @override
  String toString() {
    return 'PlanFeatures{feature: $feature, isEnabled: $isEnabled}';
  }

  PlanFeatures({this.feature, this.isEnabled});

  PlanFeatures.fromJson(Map<String, dynamic> json) {
    feature =
    json['feature'] != null ? Feature.fromJson(json['feature']) : null;
    isEnabled = json['is_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feature != null) {
      data['feature'] = feature!.toJson();
    }
    data['is_enabled'] = isEnabled;
    return data;
  }
}

class Feature {
  String? identifier;
  String? name;


  @override
  String toString() {
    return 'Feature{identifier: $identifier, name: $name}';
  }

  Feature({this.identifier, this.name});

  Feature.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['name'] = name;
    return data;
  }
}