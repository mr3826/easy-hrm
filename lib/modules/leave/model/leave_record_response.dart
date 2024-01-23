class LeaveRecord {
  List<GetLeaveRecordsForApp>? getLeaveRecordsForApp;

  LeaveRecord({this.getLeaveRecordsForApp});

  LeaveRecord.fromJson(Map<String, dynamic> json) {
    if (json['getLeaveRecordsForApp'] != null) {
      getLeaveRecordsForApp = <GetLeaveRecordsForApp>[];
      json['getLeaveRecordsForApp'].forEach((v) {
        getLeaveRecordsForApp!.add(GetLeaveRecordsForApp.fromJson(v));
      });
    }
  }
}

class GetLeaveRecordsForApp {
  String? date;
  List<Data>? data;

  GetLeaveRecordsForApp({this.date, this.data});

  GetLeaveRecordsForApp.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? createdAt;
  String? description;
  String? endDate;
  List<Files>? files;
  LeaveType? leaveType;
  String? status;
  dynamic numberOfDays;
  String? startDate;
  String? id;

  Data({
    this.createdAt,
    this.description,
    this.endDate,
    this.files,
    this.leaveType,
    this.status,
    this.numberOfDays,
    this.startDate,
    this.id
  });

  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    description = json['description'];
    endDate = json['end_date'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    leaveType = json['leaveType'] != null
        ? LeaveType.fromJson(json['leaveType'])
        : null;
    status = json['status'];
    numberOfDays = json['number_of_days'];
    startDate = json['start_date'];
    id = json['id'];
  }
}

class Files {
  String? name;

  Files({this.name});

  Files.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

class LeaveType {
  String? type;
  String? leaveId;
  String? leaveName;
  bool? isAddNoteRequired;
  bool? isAttachDocumentRequired;


  LeaveType({this.type, this.leaveId, this.leaveName,this.isAddNoteRequired,this.isAttachDocumentRequired});

  LeaveType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    leaveId = json['id'];
    leaveName = json['name'];
    isAddNoteRequired = json['add_note_required'];
    isAttachDocumentRequired = json['attach_document_required'];
  }
}
