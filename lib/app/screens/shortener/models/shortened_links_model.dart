class ShortenedLink {
  final String originalUrl;
  final String shortUrl;
  final DateTime createdAt;

  ShortenedLink({
    required this.originalUrl,
    required this.shortUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'original_url': originalUrl,
        'short_url': shortUrl,
        'created_at': createdAt.toIso8601String(),
      };

  factory ShortenedLink.fromJson(Map<String, dynamic> json) {
    return ShortenedLink(
      originalUrl: json['original_url'],
      shortUrl: json['short_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
