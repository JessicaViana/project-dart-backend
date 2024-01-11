// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewsModel {
  final int id;
  final String title;
  final String description;
  final String image;
  // final DateTime publishedDate;
  // final DateTime? updateDate;

  NewsModel(
    this.id,
    this.title,
    this.description,
    this.image,
    // this.publishedDate,
    // this.updateDate,
  );

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      json['id'],
      json['title'],
      json['description'],
      json['image'],
      // DateTime.now(),
      // json['updateDate'] != null
      //     ? DateTime.fromMicrosecondsSinceEpoch(
      //         (json['updateDate']),
      //       )
      //     : null,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        // 'publishedDate': publishedDate,
        // 'updateDate': updateDate
      };

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, description: $description, image: $image)';
    //  publishedDate: $publishedDate, updateDate: $updateDate)';
  }
}
