class OrganizationInfoDetails {
  GetUserOrganizations? getUserOrganizations;

  OrganizationInfoDetails({this.getUserOrganizations});

  OrganizationInfoDetails.fromJson(Map<String, dynamic> json) {
    getUserOrganizations = json['getUserOrganizations'] != null
        ?  GetUserOrganizations.fromJson(json['getUserOrganizations'])
        : null;
  }

}

class GetUserOrganizations {
  List<Data>? data;

  GetUserOrganizations({this.data});

  GetUserOrganizations.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }
}

class Data {
  Organization? organization;

  Data({this.organization});

  Data.fromJson(Map<String, dynamic> json) {
    organization = json['organization'] != null
        ?  Organization.fromJson(json['organization'])
        : null;
  }

}

class Organization {
  String? name;
  String? id;
  OrganizationSetting? organizationSetting;

  Organization({this.name, this.id, this.organizationSetting});

  Organization.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    organizationSetting = json['organization_setting'] != null
        ? OrganizationSetting.fromJson(json['organization_setting'])
        : null;
  }

}

class OrganizationSetting {
  String? logoKey;

  OrganizationSetting({this.logoKey});

  OrganizationSetting.fromJson(Map<String, dynamic> json) {
    logoKey = json['logo_key'];
  }

}
