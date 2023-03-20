import 'dart:convert';

class Welcome {
  Welcome({
    this.title,
    required this.rows,
  });

  String ? title;
  List<Row> rows;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    title: json["title"],
    rows: json["rows"]==null ? []:List<Row>.from(json["rows"].map((x)=>Row.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
  };
}

class Row {
  Row({
    this.title,
    this.description,
    this.imageHref,
  });

  String? title;
  String? description;
  String? imageHref;

  factory Row.fromJson(Map<String, dynamic> json) => Row(
    title: json["title"] ?? 'NA',
    description: json["description"] ?? 'NA',
    imageHref: json["imageHref"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "imageHref": imageHref,
  };
}
