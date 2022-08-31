class News {
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late String publishedAt;
  late String content;

  News(
      {
      required this.title,
      required this.content,
      required this.description,
      required this.publishedAt,
      required this.url,
      required this.urlToImage});
}
