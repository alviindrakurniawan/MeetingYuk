
// To parse this JSON data, do
//
//     final explore = exploreFromJson(jsonString);

import 'dart:convert';

Recommendation recommendationFromJson(String str) => Recommendation.fromJson(json.decode(str));

String recommendationToJson(Recommendation data) => json.encode(data.toJson());

class Recommendation {
  final String? id;
  final String? address;
  final double? distanceInKm;
  final String? imageUrl;
  final String? name;
  final dynamic openingHours;
  final String? openingHoursFriday;
  final String? openingHoursMonday;
  final String? openingHoursSaturday;
  final dynamic openingHoursSunday;
  final String? openingHoursThursday;
  final String? openingHoursTuesday;
  final String? openingHoursWednesday;
  final double? predictedRating;
  final double? ratings;
  final int? reviewCount;
  final List<Room>? rooms;

  Recommendation({
    this.id,
    this.address,
    this.distanceInKm,
    this.imageUrl,
    this.name,
    this.openingHours,
    this.openingHoursFriday,
    this.openingHoursMonday,
    this.openingHoursSaturday,
    this.openingHoursSunday,
    this.openingHoursThursday,
    this.openingHoursTuesday,
    this.openingHoursWednesday,
    this.predictedRating,
    this.ratings,
    this.reviewCount,
    this.rooms,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
    id: json["_id"],
    address: json["address"],
    distanceInKm: json["distance_in_km"]?.toDouble(),
    imageUrl: json["image_url"],
    name: json["name"],
    openingHours: json["opening_hours"],
    openingHoursFriday: json["opening_hours.friday"],
    openingHoursMonday: json["opening_hours.monday"],
    openingHoursSaturday: json["opening_hours.saturday"],
    openingHoursSunday: json["opening_hours.sunday"],
    openingHoursThursday: json["opening_hours.thursday"],
    openingHoursTuesday: json["opening_hours.tuesday"],
    openingHoursWednesday: json["opening_hours.wednesday"],
    predictedRating: json["predicted_rating"]?.toDouble(),
    ratings: json["ratings"],
    reviewCount: json["review_count"],
    rooms: json["rooms"] == null ? [] : List<Room>.from(json["rooms"]!.map((x) => Room.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "address": address,
    "distance_in_km": distanceInKm,
    "image_url": imageUrl,
    "name": name,
    "opening_hours": openingHours,
    "opening_hours.friday": openingHoursFriday,
    "opening_hours.monday": openingHoursMonday,
    "opening_hours.saturday": openingHoursSaturday,
    "opening_hours.sunday": openingHoursSunday,
    "opening_hours.thursday": openingHoursThursday,
    "opening_hours.tuesday": openingHoursTuesday,
    "opening_hours.wednesday": openingHoursWednesday,
    "predicted_rating": predictedRating,
    "ratings": ratings,
    "review_count": reviewCount,
    "rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x.toJson())),
  };
}

class Room {
  final List<String>? facilities;
  final List<String>? imageUrls;
  final int? maxCapacity;
  final int? maxDuration;
  final String? name;
  final int? price;
  final String? roomId;

  Room({
    this.facilities,
    this.imageUrls,
    this.maxCapacity,
    this.maxDuration,
    this.name,
    this.price,
    this.roomId,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    facilities: json["facilities"] == null ? [] : List<String>.from(json["facilities"]!.map((x) => x)),
    imageUrls: json["image_urls"] == null ? [] : List<String>.from(json["image_urls"]!.map((x) => x)),
    maxCapacity: json["max_capacity"],
    maxDuration: json["max_duration"],
    name: json["name"],
    price: json["price"],
    roomId: json["room_id"],
  );

  Map<String, dynamic> toJson() => {
    "facilities": facilities == null ? [] : List<dynamic>.from(facilities!.map((x) => x)),
    "image_urls": imageUrls == null ? [] : List<dynamic>.from(imageUrls!.map((x) => x)),
    "max_capacity": maxCapacity,
    "max_duration": maxDuration,
    "name": name,
    "price": price,
    "room_id": roomId,
  };
}

