// To parse this JSON data, do
//
//     final characterModel = characterModelFromJson(jsonString);

import 'dart:convert';

CharacterModel characterModelFromJson(String str) =>
    CharacterModel.fromJson(json.decode(str));

String characterModelToJson(CharacterModel data) => json.encode(data.toJson());

class CharacterModel {
  Info info;
  List<Character> character;

  CharacterModel({
    required this.info,
    required this.character,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        info: Info.fromJson(json["info"]),
        character: List<Character>.from(
            json["results"].map((x) => Character.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(character.map((x) => x.toJson())),
      };
}

class Character {
  int id;
  String name;
  Status status;
  String species;
  String type;
  String gender;
  Location origin;
  Location location;
  String image;
  List<String>? episode;
  String? url;
  DateTime? created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin: Location.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}

class Location {
  String name;
  String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

enum Status { alive, dead, unknown }

final statusValues = EnumValues({
  "Alive": Status.alive,
  "Dead": Status.dead,
  "unknown": Status.unknown,
  'alive': Status.alive,
  'dead': Status.dead
});

class Info {
  int count;
  int pages;
  dynamic next;
  dynamic prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
