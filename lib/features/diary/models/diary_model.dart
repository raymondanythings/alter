class DiaryModel {
  final String? id;
  final String title;
  final String diary;
  final String creatorUid;
  final String creator;
  final String picture;
  final int createdAt;

  DiaryModel({
    this.id,
    required this.title,
    required this.diary,
    required this.creatorUid,
    required this.creator,
    required this.picture,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "diary": diary,
      "creatorUid": creatorUid,
      "creator": creator,
      "picture": picture,
      "createdAt": createdAt,
    };
  }

  DiaryModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        diary = json["diary"],
        creatorUid = json["creatorUid"],
        creator = json["creator"],
        picture = json["picture"],
        createdAt = json["createdAt"];
}
