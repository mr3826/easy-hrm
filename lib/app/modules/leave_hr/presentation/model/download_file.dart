class DownloadFile {
  String? getFileSignedUrl;

  DownloadFile({this.getFileSignedUrl});

  DownloadFile.fromJson(Map<String, dynamic> json) {
    getFileSignedUrl = json['getFileSignedUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getFileSignedUrl'] = this.getFileSignedUrl;
    return data;
  }
}
