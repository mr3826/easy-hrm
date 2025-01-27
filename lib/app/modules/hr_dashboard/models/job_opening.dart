class JobOpening {
  GetJobs? getJobs;

  JobOpening({this.getJobs});

  JobOpening.fromJson(Map<String, dynamic> json) {
    getJobs =
    json['getJobs'] != null ? GetJobs.fromJson(json['getJobs']) : null;
  }

}

class GetJobs {
  List<Data>? data;

  GetJobs({this.data});

  GetJobs.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
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


}

class HiringStages {
  String? title;
  int? noOfApplicant;

  HiringStages({this.title, this.noOfApplicant});

  HiringStages.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    noOfApplicant = json['no_of_applicant'];
  }

}
