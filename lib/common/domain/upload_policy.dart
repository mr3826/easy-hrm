class UploadPolicyResponse {
  GetUploadPolicy? getUploadPolicy;

  UploadPolicyResponse({this.getUploadPolicy});

  UploadPolicyResponse.fromJson(Map<String, dynamic> json) {
    getUploadPolicy = json['getUploadPolicy'] != null
        ? new GetUploadPolicy.fromJson(json['getUploadPolicy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getUploadPolicy != null) {
      data['getUploadPolicy'] = this.getUploadPolicy!.toJson();
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
        policyData!.add(new PolicyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.policyData != null) {
      data['policy_data'] = this.policyData!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
