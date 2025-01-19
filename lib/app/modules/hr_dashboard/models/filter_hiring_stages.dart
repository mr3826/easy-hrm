class FilterHiringStages {
  GetHiringStagesForDropDown? getHiringStagesForDropDown;

  FilterHiringStages({this.getHiringStagesForDropDown});

  FilterHiringStages.fromJson(Map<String, dynamic> json) {
    getHiringStagesForDropDown = json['getHiringStagesForDropDown'] != null
        ? new GetHiringStagesForDropDown.fromJson(
        json['getHiringStagesForDropDown'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getHiringStagesForDropDown != null) {
      data['getHiringStagesForDropDown'] =
          this.getHiringStagesForDropDown!.toJson();
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
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stage_ids'] = this.stageIds;
    data['title'] = this.title;
    return data;
  }
}
