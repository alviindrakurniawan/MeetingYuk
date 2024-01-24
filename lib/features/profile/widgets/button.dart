import 'package:flutter/material.dart';
import 'package:MeetingYuk/common/ulits/color.dart';


class CustomFilledButton extends StatelessWidget {
  final Widget title;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final Color color;
  final double borderRad;

  const CustomFilledButton({
    Key? key,
    required this.title,
    this.width = double.infinity,
    this.height = 50,
    this.borderRad= 50,
    this.onPressed,
    this.color = primaryColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRad),
          ),
        ),
        child: title
      ),
    );
  }
}


class CustomTextButton extends StatelessWidget {
  final Widget title;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final Color color;
  final double borderRad;

  const CustomTextButton({
    Key? key,
    required this.title,
    this.width = double.infinity,
    this.height = 50,
    this.borderRad= 50,
    this.onPressed,
    this.color = primaryColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRad),
            ),
          ),
          child: title
      ),
    );
  }
}