class NotificationResponse {
  GetNotificationActivities? getNotificationActivities;

  NotificationResponse({this.getNotificationActivities});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    getNotificationActivities = json['getNotificationActivities'] != null
        ? GetNotificationActivities.fromJson(json['getNotificationActivities'])
        : null;
  }
}

class GetNotificationActivities {
  List<Data>? data;
  MetaData? metaData;

  GetNotificationActivities({this.data, this.metaData});

  GetNotificationActivities.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    metaData =
        json['metaData'] != null ? MetaData.fromJson(json['metaData']) : null;
  }
}

class Data {
  Notification? notification;

  Data({this.notification});

  Data.fromJson(Map<String, dynamic> json) {
    notification = json['notification'] != null
        ? Notification.fromJson(json['notification'])
        : null;
  }
}

class Notification {
  String? id;
  String? createdAt;
  String? context;
  Changer? changer;
  Timeline? timeline;
  Timeline? leave;
  Affectee? affectee;
  Department? department;
  Job? job;

  Notification(
      {this.id,
      this.createdAt,
      this.context,
      this.changer,
      this.timeline,
      this.leave,
      this.affectee,
      this.department,
      this.job});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    context = json['context'];
    changer =
        json['changer'] != null ? Changer.fromJson(json['changer']) : null;
    timeline =
        json['timeline'] != null ? Timeline.fromJson(json['timeline']) : null;
    leave = json['leave'] != null ? Timeline.fromJson(json['leave']) : null;
    affectee =
        json['affectee'] != null ? Affectee.fromJson(json['affectee']) : null;
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    job = json['job'] != null ? Job.fromJson(json['job']) : null;
  }
}

class Changer {
  Profile? profile;

  Changer({this.profile});

  Changer.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }
}

class Profile {
  String? firstName;
  String? lastName;

  Profile({this.firstName, this.lastName});

  Profile.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
  }
}

class Timeline {
  String? startDate;

  Timeline({this.startDate});

  Timeline.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
  }
}

class Affectee {
  String? id;

  Affectee({this.id});

  Affectee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}

class Department {
  String? name;
  String? managerId;

  Department({this.name, this.managerId});

  Department.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    managerId = json['manager_id'];
  }
}

class Job {
  String? title;
  String? id;

  Job({this.title, this.id});

  Job.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
  }
}

class MetaData {
  int? totalRows;
  NotificationCounts? notificationCounts;

  MetaData({this.totalRows,this.notificationCounts});

  MetaData.fromJson(Map<String, dynamic> json) {
    totalRows = json['totalRows'];
    notificationCounts =
    json['notificationCounts'] != null ? NotificationCounts.fromJson(json['notificationCounts']) : null;

  }

  @override
  String toString() {
    return 'MetaData{totalRows: $totalRows, notificationCounts: $notificationCounts}';
  }
}

class NotificationCounts {
  int? seenCount;
  int? unSeenCount;

  NotificationCounts(this.seenCount, this.unSeenCount);

  NotificationCounts.fromJson(Map<String, dynamic> json){
    seenCount = json['seen_count'];
    unSeenCount = json['unseen_count'];
  }

  @override
  String toString() {
    return 'NotificationCounts{seenCount: $seenCount, unSeenCount: $unSeenCount}';
  }
}
