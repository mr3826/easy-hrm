class SignInResponse {
  String? message;
  Data? data;
  String? ordId;

  SignInResponse({this.message, this.data, this.ordId});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    ordId = json['organization_id'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? accessToken;
  String? idToken;
  int? expiresIn;
  String? refreshToken;

  Data({this.accessToken, this.idToken, this.expiresIn, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    idToken = json['idToken'];
    expiresIn = json['expiresIn'];
    refreshToken = json['refreshToken'];
  }
}
