import 'package:flutter/material.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CafeCardRecom extends StatelessWidget {
  final String imageUrl;
  final String namePlace;
  final String nameRoom;
  final String startAt;
  final String endAt;
  final int totalPrice;
  final VoidCallback? onTap;

  const CafeCardRecom(
      {required this.imageUrl,
        required this.namePlace,
        required this.nameRoom,
        required this.startAt,
        required this.endAt,
        required this.totalPrice,
        this.onTap});

  @override
  Widget build(BuildContext context) {
    String getTime(String dateTime) {
      final dt = DateTime.parse(dateTime);
      final time =
          "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
      return time;
    }
    String getDay(String dateTime) {
      final dt = DateTime.parse(dateTime);
      final time =
          "${DateFormat('d MMMM  yyyy').format(dt)}";
      return time;
    }
    String intToMoneyString(int number) {
      final buffer = StringBuffer();
      final str = number.toString().split('').reversed.toList();

      for (int i = 0; i < str.length; i++) {
        if (i > 0 && i % 3 == 0) {
          buffer.write('.');
        }
        buffer.write(str[i]);
      }

      return buffer.toString().split('').reversed.join();
    }

    final Image errorImage = Image.asset("assets/images/logo_color.png");
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
      margin: EdgeInsets.only(top: 5,bottom: 10),
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
                errorBuilder:  (context, error, stackTrace) => errorImage,
                fit: BoxFit.cover,
                height: 145,
              ),
            ),
            Container(
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
                          '$namePlace',
                          style: boldPrim16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text('$nameRoom',style: mediumBlack14,),
                  SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range_rounded,size: 16),
                      SizedBox(width: 5),
                      Text('${getDay(startAt)}',style: regularBlack12,),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon( Icons.access_time_rounded,size: 16),
                      SizedBox(width: 5),
                      Text(
                        '${getTime(startAt)} - ${getTime(endAt)}',
                        style: regularBlack12,
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 20,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${intToMoneyString(totalPrice)}',
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
