class Post {
  final String title;
  final String description;
  final String link;

  Post({
    required this.title,
    required this.description,
    required this.link,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title']["rendered"] ?? '',
      description: json['content']["plain"] ?? '',
      link: json['link'] ?? '',
    );
  }
}