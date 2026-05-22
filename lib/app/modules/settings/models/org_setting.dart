class OrgSetting {
  GetOrganizationSetting? getOrganizationSetting;

  OrgSetting({this.getOrganizationSetting});

  OrgSetting.fromJson(Map<String, dynamic> json) {
    getOrganizationSetting = json['getOrganizationSetting'] != null
        ? GetOrganizationSetting.fromJson(json['getOrganizationSetting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getOrganizationSetting != null) {
      data['getOrganizationSetting'] = getOrganizationSetting!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['time_zone'] = timeZone;
    data['time_format'] = timeFormat;
    data['country_code'] = countryCode;
    data['date_format'] = dateFormat;
    data['language'] = language;
    return data;
  }
}
