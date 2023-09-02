import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/style.dart';

class CustomPassForm extends StatelessWidget {
  final String title;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final Function(String)? onChange;
  final bool isShowTitle;
  final Function(String)? onFieldSubmitted;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Callback toogle;
  final bool passwordObscure;
  final bool enable;

  const CustomPassForm({Key? key,
    required this.title,
    this.obscureText = false,
    this.focusNode,
    required this.controller,
    this.isShowTitle = true,
    this.onFieldSubmitted,
    this.onChange,
    required this.keyboardType,
    required this.validator,
    required this.toogle,
    required this.passwordObscure,
    this.enable=false
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
              '$title',
              style: mediumBlack14
          ),
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
            suffixIcon: IconButton(
                icon: Icon(
                    passwordObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: toogle
            ),
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
          enabled:enable,

        ),
      ],
    );
  }
}
