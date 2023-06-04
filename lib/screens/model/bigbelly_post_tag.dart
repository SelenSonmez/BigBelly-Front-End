class BigBellyPostTag {
  BigBellyPostTag({required this.tagName, required this.id});
  int id;
  String tagName;

  factory BigBellyPostTag.fromMap(Map<String, dynamic> map) {
    return BigBellyPostTag(tagName: map['name'], id: map["id"]);
  }
  @override
  String toString() => tagName;
  toMap() {}
}
