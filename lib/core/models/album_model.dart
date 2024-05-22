class AlbumModel {
  int? userId;
  int? id;
  String? title;

  AlbumModel({this.userId, this.id, this.title});

  AlbumModel.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    id = json["id"];
    title = json["title"];
  }

  static List<AlbumModel> fromList(List<dynamic> list) {
    return list.map((map) => AlbumModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userId"] = userId;
    data["id"] = id;
    data["title"] = title;
    return data;
  }

  AlbumModel copyWith({
    int? userId,
    int? id,
    String? title,
  }) =>
      AlbumModel(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
      );
}
