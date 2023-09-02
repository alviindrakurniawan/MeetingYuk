import 'dart:convert';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
  final String id;
  final String ownerId;
  final String name;
  final String address;
  final double ratings;
  final OpeningHours openingHours;
  final String imageUrl;
  final List<Tag> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  Place({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.address,
    required this.ratings,
    required this.openingHours,
    required this.imageUrl,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    id: json["id"],
    ownerId: json["owner_id"],
    name: json["name"],
    address: json["address"],
    ratings:(json["ratings"] is int) ? (json["ratings"] as int).toDouble() : json["ratings"],
    openingHours: OpeningHours.fromJson(json["opening_hours"]),
    imageUrl: json["image_url"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner_id": ownerId,
    "name": name,
    "address": address,
    "ratings": ratings,
    "opening_hours": openingHours.toJson(),
    "image_url": imageUrl,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class OpeningHours {
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;

  OpeningHours({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
    monday: _formatTime(json["monday"]),
    tuesday: _formatTime(json["tuesday"]),
    wednesday: _formatTime(json["wednesday"]),
    thursday: _formatTime(json["thursday"]),
    friday: _formatTime(json["friday"]),
    saturday: _formatTime(json["saturday"]),
    sunday: _formatTime(json["sunday"]),
  );
  static String _formatTime(String? time) {
    if(time==''){
      return '';
    } if (time != null) {
      final timeRanges = time.split('-');
      final startTimeParts = timeRanges[0].split(':');
      final endTimeParts = timeRanges[1].split(':');
      final startHour = startTimeParts[0].padLeft(2, '0');
      final startMinute = startTimeParts[1].padLeft(2, '0');

      final endHour = endTimeParts[0].padLeft(2, '0');
      final endMinute = endTimeParts[1].padLeft(2, '0');

      //modifiy return
      return '$startHour:$startMinute-$endHour:$endMinute';
    }
    else {
      return '';
    }
  }

  Map<String, dynamic> toJson() => {
    "monday": monday,
    "tuesday": tuesday,
    "wednesday": wednesday,
    "thursday": thursday,
    "friday": friday,
    "saturday": saturday,
    "sunday": sunday,
  };
}

class Tag {
  final String id;
  final String tag;

  Tag({
    required this.id,
    required this.tag,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    tag: json["tag"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tag": tag,
  };
}

