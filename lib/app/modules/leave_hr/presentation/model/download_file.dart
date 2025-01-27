class DownloadFile {
  String? getFileSignedUrl;

  DownloadFile({this.getFileSignedUrl});

  DownloadFile.fromJson(Map<String, dynamic> json) {
    getFileSignedUrl = json['getFileSignedUrl'];
  }
}
