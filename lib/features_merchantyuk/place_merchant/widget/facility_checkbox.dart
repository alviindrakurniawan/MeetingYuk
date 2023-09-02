import 'package:flutter/material.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/features/home/widget/facilities.dart';


class FacilityCheckbox extends StatelessWidget {
  final String facility;
  final void Function(bool?)? onpress;
  bool value;


  FacilityCheckbox({super.key,
    required this.facility,
    required this.onpress,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
      return ListTile(
        leading: Icon(
          facilityIcons[facility],
          color: grey,
        ),
        title: Text(facility),
        trailing: Checkbox(
          value: value,
          onChanged: onpress
        ),
      );
  }
}
