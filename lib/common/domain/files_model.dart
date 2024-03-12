class Files {
  String? name;
  dynamic size;
  dynamic createdAt;
  String? key;
  String? id;

  Files({this.name, this.size, this.createdAt, this.key, this.id});

  Files.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    size = json['size'];
    createdAt = json['createdAt'];
    key = json['key'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['size'] = size;
    data['createdAt'] = createdAt;
    data['key'] = key;
    data['id'] = id;
    return data;
  }
}
