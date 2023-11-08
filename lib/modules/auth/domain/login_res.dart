class Login {
  bool? _status;
  String? _message;
  Data? _data;

  Login({bool? status, String? message, Data? data}) {
    if (status != null) {
      _status = status;
    }
    if (message != null) {
      _message = message;
    }
    if (data != null) {
      _data = data;
    }
  }

  bool? get status => _status;
  set status(bool? status) => _status = status;
  String? get message => _message;
  set message(String? message) => _message = message;
  Data? get data => _data;
  set data(Data? data) => _data = data;

  Login.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    data['message'] = _message;
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class Data {
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _token;
  String? _fullName;

  Data(
      {int? id,
      String? firstName,
      String? lastName,
      String? email,
      String? token,
      String? fullName}) {
    if (id != null) {
      _id = id;
    }
    if (firstName != null) {
      _firstName = firstName;
    }
    if (lastName != null) {
      _lastName = lastName;
    }
    if (email != null) {
      _email = email;
    }
    if (token != null) {
      _token = token;
    }
    if (fullName != null) {
      _fullName = fullName;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get firstName => _firstName;
  set firstName(String? firstName) => _firstName = firstName;
  String? get lastName => _lastName;
  set lastName(String? lastName) => _lastName = lastName;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get token => _token;
  set token(String? token) => _token = token;
  String? get fullName => _fullName;
  set fullName(String? fullName) => _fullName = fullName;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _token = json['token'];
    _fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['first_name'] = _firstName;
    data['last_name'] = _lastName;
    data['email'] = _email;
    data['token'] = _token;
    data['full_name'] = _fullName;
    return data;
  }
}
