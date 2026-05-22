class FilterHiringStages {
  GetHiringStagesForDropDown? getHiringStagesForDropDown;

  FilterHiringStages({this.getHiringStagesForDropDown});

  FilterHiringStages.fromJson(Map<String, dynamic> json) {
    getHiringStagesForDropDown = json['getHiringStagesForDropDown'] != null
        ? GetHiringStagesForDropDown.fromJson(
        json['getHiringStagesForDropDown'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getHiringStagesForDropDown != null) {
      data['getHiringStagesForDropDown'] =
          getHiringStagesForDropDown!.toJson();
    }
    return data;
  }
}

class GetHiringStagesForDropDown {
  List<Data>? data;

  GetHiringStagesForDropDown({this.data});

  GetHiringStagesForDropDown.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<String>? stageIds;
  String? title;

  Data({this.stageIds, this.title});

  Data.fromJson(Map<String, dynamic> json) {
    stageIds = json['stage_ids'].cast<String>();
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stage_ids'] = stageIds;
    data['title'] = title;
    return data;
  }
}
