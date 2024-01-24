import 'package:flutter/material.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/style.dart';
import 'package:flutter/cupertino.dart';

class CardRoom extends StatelessWidget {
  final String imageUrl;
  final String? nameRoom;
  final String? maxPerson;
  final String? maxTimeBook;
  final VoidCallback? doubleTap;

  final String? priceRoom;

  const CardRoom(
      {required this.imageUrl,
      this.nameRoom= 'Espana Room',
      this.maxPerson='3',
      this.maxTimeBook='5',
      this.priceRoom='20,000',
      this.doubleTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: doubleTap,
      child: Container(
        width: 205,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: primaryColor,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignInside),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(imageUrl, fit: BoxFit.cover, height: 120,alignment: Alignment.center,)),
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$nameRoom', style: boldBlack12),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 12,
                        color: lightGrey,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '$maxPerson Person',
                        style: regularLightGrey12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        size: 12,
                        color: lightGrey,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Max $maxTimeBook Hours',
                        style: regularLightGrey12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10,left: 8,right: 8),
              height: 25,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const []),
              child: Center(
                child: Text(
                  '$priceRoom',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
