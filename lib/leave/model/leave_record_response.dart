import '../../../common/domain/files_model.dart';

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
  String? totalLeaveMinutes;

  Data(
      {this.createdAt,
      this.description,
      this.endDate,
      this.files,
      this.leaveType,
      this.status,
      this.numberOfDays,
      this.startDate,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    description = json['description'];
    endDate = json['end_date'];
    totalLeaveMinutes = json['totalLeaveMinutes'];
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




class LeaveType {
  String? type;
  String? leaveId;
  String? fileKey;
  String? leaveName;
  bool? isAddNoteRequired;
  bool? isAttachDocumentRequired;

  LeaveType(
      {this.type,
      this.leaveId,
        this.fileKey,
      this.leaveName,
      this.isAddNoteRequired,
      this.isAttachDocumentRequired});

  LeaveType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    leaveId = json['id'];
    leaveName = json['name'];
    fileKey = json['fileKey'];
    isAddNoteRequired = json['add_note_required'];
    isAttachDocumentRequired = json['attach_document_required'];
  }
}
