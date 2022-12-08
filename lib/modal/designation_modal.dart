import 'dart:convert';

List<Itemmodal> itemmodalFromJson(String str) =>
    List<Itemmodal>.from(json.decode(str).map((x) => Itemmodal.fromJson(x)));

String itemmodalToJson(List<Itemmodal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Itemmodal {
  Itemmodal({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final dynamic updatedAt;

  factory Itemmodal.fromJson(Map<String, dynamic> json) => Itemmodal(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
