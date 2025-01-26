class OrgSetting {
  GetOrganizationSetting? getOrganizationSetting;

  OrgSetting({this.getOrganizationSetting});

  OrgSetting.fromJson(Map<String, dynamic> json) {
    getOrganizationSetting = json['getOrganizationSetting'] != null
        ? new GetOrganizationSetting.fromJson(json['getOrganizationSetting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getOrganizationSetting != null) {
      data['getOrganizationSetting'] = this.getOrganizationSetting!.toJson();
    }
    return data;
  }
}

class GetOrganizationSetting {
  String? id;
  String? timeZone;
  String? timeFormat;
  String? countryCode;
  String? dateFormat;
  String? language;

  GetOrganizationSetting(
      {this.id,
        this.timeZone,
        this.timeFormat,
        this.countryCode,
        this.dateFormat,
        this.language});

  GetOrganizationSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeZone = json['time_zone'];
    timeFormat = json['time_format'];
    countryCode = json['country_code'];
    dateFormat = json['date_format'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time_zone'] = this.timeZone;
    data['time_format'] = this.timeFormat;
    data['country_code'] = this.countryCode;
    data['date_format'] = this.dateFormat;
    data['language'] = this.language;
    return data;
  }
}
