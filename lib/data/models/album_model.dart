import 'dart:convert';

class AlbumModel {
  int? userId;
  int? id;
  String? title;
  AlbumModel({
    this.userId,
    this.id,
    this.title,
  });

  static List<AlbumModel> fromList(List data) {
    List<AlbumModel> res = [];
    for (var element in data) {
      res.add(AlbumModel.fromMap(element));
    }
    return res;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      userId: map['userId']?.toInt(),
      id: map['id']?.toInt(),
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AlbumModel.fromJson(String source) =>
      AlbumModel.fromMap(json.decode(source));
}
