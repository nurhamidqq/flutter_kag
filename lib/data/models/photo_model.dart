class PhotoModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;
  PhotoModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });
  static List<PhotoModel> fromList(List data) {
    List<PhotoModel> res = [];
    for (var element in data) {
      res.add(PhotoModel.fromJson(element));
    }
    return res;
  }

  PhotoModel.fromJson(Map<String, dynamic> map) {
    albumId = map['albumId']?.toInt();
    id = map['id']?.toInt();
    title = map['title'];
    url = map['url'];
    thumbnailUrl = map['thumbnailUrl'];
  }
}
