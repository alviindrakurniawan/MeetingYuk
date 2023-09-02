// To parse this JSON data, do
//
//     final detailPlace = detailPlaceFromJson(jsonString);
import 'dart:convert';

DetailPlace detailPlaceFromJson(String str) =>
    DetailPlace.fromJson(json.decode(str));

String detailPlaceToJson(DetailPlace data) => json.encode(data.toJson());

class DetailPlace {
  final String id;
  final String ownerId;
  String name;
  String address;
  Location location;
  final double ratings;
  final int reviewCount;
  OpeningHours openingHours;
  String imageUrl;
  List<Room> rooms;
  List<Tag> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  DetailPlace({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.address,
    required this.location,
    required this.ratings,
    required this.reviewCount,
    required this.openingHours,
    required this.imageUrl,
    required this.rooms,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DetailPlace.fromJson(Map<String, dynamic> json) => DetailPlace(
        id: json["id"],
        ownerId: json["owner_id"],
        name: json["name"],
        address: json["address"],
        location: Location.fromJson(json["location"]),
        ratings: json["ratings"].toDouble(),
        reviewCount: json["review_count"],
        openingHours: OpeningHours.fromJson(json["opening_hours"]),
        imageUrl: json["image_url"]??'',
        rooms: List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "name": name,
        "address": address,
        "location": location.toJson(),
        "ratings": ratings,
        "review_count": reviewCount,
        "opening_hours": openingHours.toJson(),
        "image_url": imageUrl,
        "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class OpeningHours {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;

  OpeningHours({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  // factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
  //   monday: json["monday"],
  //   tuesday: json["tuesday"],
  //   wednesday: json["wednesday"],
  //   thursday: json["thursday"],
  //   friday: json["friday"],
  //   saturday: json["saturday"],
  //   sunday: json["sunday"],
  // );

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
    if (time == '') {
      return '';
    }
    if (time != null) {
      final timeRanges = time.split('-');
      final startTimeParts = timeRanges[0].split(':');
      final endTimeParts = timeRanges[1].split(':');
      final startHour = startTimeParts[0].padLeft(2, '0');
      final startMinute = startTimeParts[1].padLeft(2, '0');

      final endHour = endTimeParts[0].padLeft(2, '0');
      final endMinute = endTimeParts[1].padLeft(2, '0');

      //modifiy return
      return '$startHour:$startMinute-$endHour:$endMinute';
    } else {
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

class Room {
  final String roomId;
  String name;
  List<String> imageUrls;
  int maxCapacity;
  int maxDuration;
  List<String> facilities;
  int price;

  Room({
    required this.roomId,
    required this.name,
    required this.imageUrls,
    required this.maxCapacity,
    required this.maxDuration,
    required this.facilities,
    required this.price,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        roomId: json["room_id"],
        name: json["name"],
        imageUrls: List<String>.from(json["image_urls"].map((x) => x)),
        maxCapacity: json["max_capacity"],
        maxDuration: json["max_duration"],
        facilities: List<String>.from(json["facilities"].map((x) => x)),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "name": name,
        "image_urls": List<dynamic>.from(imageUrls.map((x) => x)),
        "max_capacity": maxCapacity,
        "max_duration": maxDuration,
        "facilities": List<dynamic>.from(facilities.map((x) => x)),
        "price": price,
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
