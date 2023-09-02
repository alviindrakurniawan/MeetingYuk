
import 'dart:convert';

DetailReservation detailReservationFromJson(String str) => DetailReservation.fromJson(json.decode(str));

String detailReservationToJson(DetailReservation data) => json.encode(data.toJson());

class DetailReservation {
  final String id;
  final ReservedBy reservedBy;
  final Place place;
  final Room room;
  final List<ReservedBy> participants;
  final DateTime startAt;
  final DateTime endAt;
  final int duration;
  final int totalPrice;
  final int status;
  final bool isPaid;
  final DateTime createdAt;
  final DateTime updatedAt;

  DetailReservation({
    required this.id,
    required this.reservedBy,
    required this.place,
    required this.room,
    required this.participants,
    required this.startAt,
    required this.endAt,
    required this.duration,
    required this.totalPrice,
    required this.status,
    required this.isPaid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DetailReservation.fromJson(Map<String, dynamic> json) => DetailReservation(
    id: json["id"],
    reservedBy: ReservedBy.fromJson(json["reserved_by"]),
    place: Place.fromJson(json["place"]),
    room: Room.fromJson(json["room"]),
    participants: List<ReservedBy>.from(json["participants"].map((x) => ReservedBy.fromJson(x))),
    startAt: DateTime.parse(json["start_at"]),
    endAt: DateTime.parse(json["end_at"]),
    duration: json["duration"],
    totalPrice: json["total_price"],
    status: json["status"],
    isPaid: json["is_paid"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reserved_by": reservedBy.toJson(),
    "place": place.toJson(),
    "room": room.toJson(),
    "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
    "start_at": startAt.toIso8601String(),
    "end_at": endAt.toIso8601String(),
    "duration": duration,
    "total_price": totalPrice,
    "status": status,
    "is_paid": isPaid,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class ReservedBy {
  final String id;
  final String name;
  final String email;
  final String phone;

  ReservedBy({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory ReservedBy.fromJson(Map<String, dynamic> json) => ReservedBy(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
  };
}

class Place {
  final String id;
  final String ownerId;
  final String name;
  final String address;

  Place({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.address,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    id: json["id"],
    ownerId: json["owner_id"],
    name: json["name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner_id": ownerId,
    "name": name,
    "address": address,
  };
}

class Room {
  final String roomId;
  final String name;
  final List<String> imageUrls;
  final int maxCapacity;
  final int maxDuration;
  final List<String> facilities;
  final int price;

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
