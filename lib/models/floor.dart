import 'dart:convert';

class Floor {
  String code;
  String name;
  String profileImage;
  List<String> panoramicImages;
  String category;

  Floor({this.code, this.name, this.profileImage, this.panoramicImages, this.category});

  factory Floor.fromMap(Map<String, dynamic> json) => Floor(
    code: json["code"],
    name: json["name"],
    profileImage: json["profileImage"],
    panoramicImages: json["panoramicImages"].cast<String>(),
    category: json["category"],
  );

  Map<String, dynamic> toMap() => {
    "id": code,
    "name": name,
    "profileImage": profileImage,
    "panoramicImages": panoramicImages,
    "category": category,
  };
}