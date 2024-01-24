import 'package:flutter/material.dart';
import 'package:MeetingYuk/features/home/model/detail_place.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/style.dart';

final Map<String, IconData> facilityIcons = {
  'Television': Icons.tv,
  'AC': Icons.ac_unit,
  'Whiteboard': Icons.border_all,
  'Projector': Icons.video_label,
  'Sound System': Icons.speaker,
  'Wifi': Icons.wifi,
  'Free Parking': Icons.local_parking

};

Widget widgetFacilitiesByRoomId(DetailPlace detailPlace, String roomId) {
  for (var room in detailPlace.rooms) {
    if (room.roomId == roomId) {
      return buildFacilities(room.facilities);
    }
  }
  return Text('Room ID $roomId not found'); // return a Text widget if room_id is not found
}

Widget buildFacilities(List<String> facilities) {
  return Container(
    margin: EdgeInsets.only(left: 7.5, right: 7.5, top: 10, bottom: 15),
    padding: EdgeInsets.only(left: 20, top: 10, right: 16, bottom: 10),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(0, 4.0))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        Text(
          'Facilities',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14), // Modify as needed
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 6,
        ),
        ...facilities.map((facility) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(children: [
              Icon(
                facilityIcons[facility],
                size: 22,
                color: grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  facility,
                  style:regularBlack12, // Modify as needed
                ),
              ),
            ]),
          );
        }).toList(),
      ],
    ),
  );
}


Widget buildFacilitiesPopUp(List<String> facilities) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Facilities',
        style: boldBlack14, // Modify as needed
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 6,
      ),
      ...facilities.map((facility) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(children: [
            Icon(
              facilityIcons[facility],
              size: 16,
              color: grey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                facility,
                style:regularBlack12,
              ),
            ),
          ]),
        );
      }).toList(),
    ],
  );
}
