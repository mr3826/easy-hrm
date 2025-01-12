class JobOpening {
  GetJobs? getJobs;

  JobOpening({this.getJobs});

  JobOpening.fromJson(Map<String, dynamic> json) {
    getJobs =
    json['getJobs'] != null ? new GetJobs.fromJson(json['getJobs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getJobs != null) {
      data['getJobs'] = this.getJobs!.toJson();
    }
    return data;
  }
}

class GetJobs {
  List<Data>? data;

  GetJobs({this.data});

  GetJobs.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? title;
  String? status;
  String? lastDateOfApply;
  String? location;
  dynamic noOfVacancy;
  dynamic thumbnail;
  String? type;
  List<HiringStages>? hiringStages;

  Data(
      {this.id,
        this.title,
        this.status,
        this.lastDateOfApply,
        this.location,
        this.noOfVacancy,
        this.thumbnail,
        this.type,
        this.hiringStages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    lastDateOfApply = json['last_date_of_apply'];
    location = json['location'];
    noOfVacancy = json['no_of_vacancy'];
    thumbnail = json['thumbnail'];
    type = json['type'];
    if (json['hiring_stages'] != null) {
      hiringStages = <HiringStages>[];
      json['hiring_stages'].forEach((v) {
        hiringStages!.add(new HiringStages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['last_date_of_apply'] = this.lastDateOfApply;
    data['location'] = this.location;
    data['no_of_vacancy'] = this.noOfVacancy;
    data['thumbnail'] = this.thumbnail;
    data['type'] = this.type;
    if (this.hiringStages != null) {
      data['hiring_stages'] =
          this.hiringStages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HiringStages {
  String? title;
  int? noOfApplicant;

  HiringStages({this.title, this.noOfApplicant});

  HiringStages.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    noOfApplicant = json['no_of_applicant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['no_of_applicant'] = this.noOfApplicant;
    return data;
  }
}
