import 'dart:convert';

List<Star> starFromJson(String str) =>
    List<Star>.from(json.decode(str).map((x) => Star.fromJson(x)));

class Star {
  Star({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.wikiUrl,
  });

  String title;
  String description;
  String imageUrl;
  String wikiUrl;

  factory Star.fromJson(Map<String, dynamic> json) => Star(
        title: json["title"],
        description: json["description"],
        imageUrl: json["image_url"],
        wikiUrl: json["wiki_url"],
      );
}
