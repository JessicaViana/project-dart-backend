class NewsModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final DateTime publishedDate;
  final DateTime? updateDate;

  NewsModel(
    this.id,
    this.title,
    this.description,
    this.image,
    this.publishedDate,
    this.updateDate,
  );

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, description: $description, image: $image, publishedDate: $publishedDate, updateDate: $updateDate)';
  }
}
