// To parse this JSON data, do
//
//     final itemmodal2 = itemmodal2FromJson(jsonString);

import 'dart:convert';

List<Itemmodal2> itemmodal2FromJson(String str) =>
    List<Itemmodal2>.from(json.decode(str).map((x) => Itemmodal2.fromJson(x)));

String itemmodal2ToJson(List<Itemmodal2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Itemmodal2 {
  Itemmodal2({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final dynamic updatedAt;

  factory Itemmodal2.fromJson(Map<String, dynamic> json) => Itemmodal2(
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
