import 'dart:convert';

List<Itemmodal3> itemmodal3FromJson(String str) =>
    List<Itemmodal3>.from(json.decode(str).map((x) => Itemmodal3.fromJson(x)));

String itemmodal3ToJson(List<Itemmodal3> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Itemmodal3 {
  Itemmodal3({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.designationId,
    required this.departmentId,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final DateTime dateOfBirth;
  final int designationId;
  final int departmentId;
  final dynamic remark;
  final DateTime createdAt;
  final dynamic updatedAt;

  factory Itemmodal3.fromJson(Map<String, dynamic> json) => Itemmodal3(
        id: json["id"],
        name: json["name"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        designationId: json["designation_id"],
        departmentId: json["department_id"],
        remark: json["remark"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "designation_id": designationId,
        "department_id": departmentId,
        "remark": remark,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
