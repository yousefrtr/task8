// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

import 'dart:convert';

Result resultFromJson(String str) {
  final jsonData = json.decode(str);
  return Result.fromJson(jsonData);
}

String resultToJson(Result data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Result {
  String? text;

  Result({
    this.text,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}
