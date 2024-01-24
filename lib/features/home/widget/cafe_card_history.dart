import 'package:flutter/material.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/style.dart';
import 'package:flutter/cupertino.dart';

class CafeCardHistory extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onTap;

  const CafeCardHistory({
    required this.imageUrl,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
                height: 145,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                  color: Colors.white
              ),
              padding: EdgeInsets.only(left: 13,right: 13,bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 9),
                  Text(
                    'Cronica',
                    style: boldPrim16,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(
                        CupertinoIcons.location_solid,
                        color: primaryColor,
                        size: 10,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'Jl. Sangaji No.62, Jetis',
                        style: regularPrim12,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.star_rate, color: Color(0xFFF29E3D), size: 14),
                      Icon(
                        Icons.star_rate,
                        color: Color(0xFFF29E3D),
                        size: 14,
                      ),
                      Icon(
                        Icons.star_rate,
                        color: Color(0xFFF29E3D),
                        size: 14,
                      ),
                      Icon(
                        Icons.star_rate,
                        color: Color(0xFFF29E3D),
                        size: 14,
                      ),
                      Icon(
                        Icons.star_rate,
                        color: Color(0xFFF29E3D),
                        size: 14,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '5.0',
                        style: regularBlack12,
                      )
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Small Room',
                    style: mediumBlack12,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 20,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: []),
                    child: Center(
                      child: Text(
                        '275.000',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
