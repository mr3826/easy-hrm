class UploadPolicyResponse {
  GetUploadPolicy? getUploadPolicy;

  UploadPolicyResponse({this.getUploadPolicy});

  UploadPolicyResponse.fromJson(Map<String, dynamic> json) {
    getUploadPolicy = json['getUploadPolicy'] != null
        ? GetUploadPolicy.fromJson(json['getUploadPolicy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getUploadPolicy != null) {
      data['getUploadPolicy'] = getUploadPolicy!.toJson();
    }
    return data;
  }
}

class GetUploadPolicy {
  String? url;
  List<PolicyData>? policyData;

  GetUploadPolicy({this.url, this.policyData});

  GetUploadPolicy.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    if (json['policy_data'] != null) {
      policyData = <PolicyData>[];
      json['policy_data'].forEach((v) {
        policyData!.add(PolicyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    if (policyData != null) {
      data['policy_data'] = policyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PolicyData {
  String? name;
  String? value;

  PolicyData({this.name, this.value});

  PolicyData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
