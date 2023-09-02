import 'package:flutter/material.dart';
import 'package:meetingyuk/ulits/color.dart';

class Menu extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final String text;
  final VoidCallback onPress;

  const Menu({required this.image,required this.height,required this.width,required this.text,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.only(bottom: 7),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: borderColor,
                  offset: Offset(
                    0.0,
                    4.0,
                  ),
                  blurRadius: 4.0,
                  spreadRadius: 0.0,
                )
              ],
            ),
            child: Center(
              child: Image.asset(
                'assets/images/$image.png',
                height: height,
                width: width,
              ),
            ),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}