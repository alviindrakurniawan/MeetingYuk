import 'package:flutter/material.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/style.dart';
import 'package:flutter/cupertino.dart';

class CardCafeDistance extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String address;
  final double rating;
  final double distance;
  final VoidCallback? onTap;

  const CardCafeDistance(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.address,
      required this.rating,
      required this.distance,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget buildRating(double rating) {
      List<Widget> stars = [];

      // Add full stars
      for (int i = 0; i < rating.floor(); i++) {
        stars.add(Icon(Icons.star_sharp, color: Color(0xFFF29E3D), size: 12));
      }

      // Add a half star if there's a remainder
      if (rating - rating.floor() >= 0.5) {
        stars.add(
            Icon(Icons.star_half_sharp, color: Color(0xFFF29E3D), size: 12));
      }

      // Add empty stars to fill up to 5
      while (stars.length < 5) {
        stars.add(
            Icon(Icons.star_border_sharp, color: Color(0xFFF29E3D), size: 12));
      }
      stars.add(SizedBox(width: 5));
      stars.add(Text(
        '$rating / 5.0',
        style: regularBlack12,
      ));

      return Row(mainAxisSize: MainAxisSize.min, children: stars);
    }

    final Image errorImage = Image.asset(
      "assets/images/logo_color.png",
      fit: BoxFit.cover,
      height: 145,
    );
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ]),
      margin: EdgeInsets.only(top: 5, bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                errorBuilder: (context, error, stackTrace) => errorImage,
                fit: BoxFit.cover,
                height: 145,
              ),
            ),
            Container(
              width: 205,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: Colors.white),
              padding: EdgeInsets.only(left: 13, right: 13, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 9),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$name',
                          style: boldPrim16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.location_solid,
                        color: primaryColor,
                        size: 10,
                      ),
                      SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          '$address',
                          style: regularPrim12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 2),
                  buildRating(rating),
                  const SizedBox(height: 10),
                  Text(
                    // '1.0 Km',
                    '${distance.toStringAsFixed(2)} Km',
                    style: TextStyle(
                      fontSize: 12,
                      color: lightGrey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
