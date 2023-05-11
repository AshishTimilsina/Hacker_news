// ignore_for_file: public_member_api_docs, sort_constructors_first
class Comment {
  String? by;
  int? id;
  int? parent;
  List? kids;
  String? text;
  int? time;
  String? type;
  Comment({
    this.by,
    this.kids,
    this.id,
    this.time,
    this.type,
    this.text,
    this.parent,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      by: json['by'],
      parent: json['parent'],
      text: json['text'],
      id: json['id'],
      time: json['time'],
      kids: json['kids'],
      type: json['type'],
    );
  }
}
