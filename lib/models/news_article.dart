class NewsArticle {
  final String category;
  final DateTime dateTime;
  final String headline;
  final int id;
  final String imageUrl;
  final String related;
  final String source;
  final String summary;
  final String url;

  NewsArticle({
    required this.category,
    required this.dateTime,
    required this.headline,
    required this.id,
    required this.imageUrl,
    required this.related,
    required this.source,
    required this.summary,
    required this.url,
  });

  // Factory method to create a NewsArticle from JSON
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      category: json['category'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['datetime'] * 1000),
      headline: json['headline'],
      id: json['id'],
      imageUrl: json['image'],
      related: json['related'],
      source: json['source'],
      summary: json['summary'],
      url: json['url'],
    );
  }

  // Method to convert NewsArticle to JSON
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'datetime': dateTime.millisecondsSinceEpoch ~/ 1000,
      'headline': headline,
      'id': id,
      'image': imageUrl,
      'related': related,
      'source': source,
      'summary': summary,
      'url': url,
    };
  }
}
