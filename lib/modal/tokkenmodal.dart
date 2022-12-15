import 'dart:convert';

tokkenmodal tokkenmodalFromJson(String str) =>
    tokkenmodal.fromJson(json.decode(str));

String tokkenmodalToJson(tokkenmodal data) => json.encode(data.toJson());

class tokkenmodal {
  tokkenmodal({
    required this.token,
  });

  final String token;

  factory tokkenmodal.fromJson(Map<String, dynamic> json) => tokkenmodal(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
