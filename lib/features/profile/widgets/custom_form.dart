import 'package:flutter/material.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/style.dart';

class CustomForm extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? hintText;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final Function(String)? onChange;
  final bool isShowTitle;
  final Function(String)? onFieldSubmitted;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool enable;

  const CustomForm(
      {Key? key,
      this.title,
      this.titleStyle = mediumBlack14,
      this.obscureText = false,
      this.hintText,
      this.focusNode,
      required this.controller,
      this.isShowTitle = true,
      this.onFieldSubmitted,
      this.onChange,
      required this.keyboardType,
      required this.validator,
      this.enable=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text('$title', style: titleStyle),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          focusNode: focusNode,
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChange,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              //focus
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: borderFormColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: borderFormColorDisable),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: primaryColor),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
          onFieldSubmitted: onFieldSubmitted,
          enabled: enable,
        ),
      ],
    );
  }
}
