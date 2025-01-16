class FileSignedUrl {
  String? getFileSignedUrl;
  FileSignedUrl({this.getFileSignedUrl});
  FileSignedUrl.fromJson(Map<String, dynamic> json) {
    getFileSignedUrl = json['getFileSignedUrl'];
  }
}
