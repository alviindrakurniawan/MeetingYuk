class Reservation {
  final String id;
  final String reservedBy;
  final String placeId;
  final String placeName;
  final String placeImage;
  final String roomId;
  final String roomName;
  final List<String> participantsId;
  final String startAt;
  final String endAt;
  final int duration;
  final int totalPrice;
  final int status;
  final bool isPaid;
  final String createdAt;
  final String updatedAt;

  Reservation(
      {required this.id,
      required this.reservedBy,
      required this.placeId,
      required this.placeName,
      required this.placeImage,
      required this.roomId,
      required this.roomName,
      required this.participantsId,
      required this.startAt,
      required this.endAt,
      required this.duration,
      required this.totalPrice,
      required this.status,
      required this.isPaid,
      required this.createdAt,
      required this.updatedAt});

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      reservedBy: json['reserved_by'],
      placeId: json['place_id'],
      placeName: json['place_name'],
      placeImage: json['place_image_url'],
      roomId: json['room_id'],
      roomName: json['room_name'],
      participantsId: List<String>.from(json['participants_id'].map((x) => x)),
      startAt: json['start_at'],
      endAt: json['end_at'],
      duration: json['duration'],
      totalPrice: json['total_price'],
      status: json['status'],
      isPaid: json['is_paid'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
