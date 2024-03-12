class TokenModel {
  String? accessToken;
  String? idToken;
  String? refreshToken;

  TokenModel({this.accessToken, this.idToken, this.refreshToken});

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    idToken = json['idToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['idToken'] = idToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
