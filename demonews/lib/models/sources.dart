class SourceModel {
  final String author;
  final String category;
  final String id;
  final String name;
  final String title;
  final String description;
  final String url;
  final String img;
  final String date;
  final String content;

  SourceModel(
    this.author,
    this.category,
    this.id,
    this.name,
    this.title,
    this.description,
    this.url,
    this.img,
    this.date,
    this.content,
  );

  SourceModel.fromJson(Map<String, dynamic> json)
      : author = json["author"],
        category = json["category"],
        id = json["id"],
        name = json["name"],
        title = json["title"],
        description = json["description"],
        url = json["url"],
        img = json["urlToImage"],
        date = json["publishedAt"],
        content = json["content"];
}
