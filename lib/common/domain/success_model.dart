class SuccessModel {
  String? message;

  SuccessModel({this.message});

  SuccessModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
