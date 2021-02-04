import 'dart:convert';
class Floor {
  int id;
  String name;
  String description;
  String image;
  var tags;
  var categories;

  Floor({this.id, this.name, this.description, this.image, this.tags, this.categories});

  factory Floor.fromMap(Map<String, dynamic> json) => Floor(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    tags: json["tags"],
    categories: json["categories"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "tags": tags,
    "categories": categories,
  };
}