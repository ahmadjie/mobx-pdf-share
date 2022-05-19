import 'dart:convert';

List<ListPhotos> listPhotosFromJson(String str) =>
    List<ListPhotos>.from(json.decode(str).map((x) => ListPhotos.fromJson(x)));

String listPhotosToJson(List<ListPhotos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListPhotos {
  ListPhotos({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  factory ListPhotos.fromJson(Map<String, dynamic> json) => ListPhotos(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}
