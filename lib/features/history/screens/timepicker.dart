import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meetingyuk/features/history/view_model/detailhistory_viewmodel.dart';
import 'package:meetingyuk/features/history/view_model/timepicker_viewmodel.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/style.dart';
class TimePickerScreen extends StatelessWidget {
  final TimePickerController controller = Get.put(TimePickerController());

  void _showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          // children: [
          //   // Date Button
          //   CupertinoButton(
          //     child: Text("Select Date"),
          //     onPressed: () async{
          //
          //       _showDialog(
          //         context,
          //         CupertinoDatePicker(
          //           onDateTimeChanged: (DateTime newDateTime) {
          //             controller.selectedDate.value = newDateTime;
          //             controller.fetchBookedData(newDateTime);
          //           },
          //           mode: CupertinoDatePickerMode.date,
          //         ),
          //       );
          //     },
          //   ),
          //   // ElevatedButton(
          //   //   onPressed: ()async{
          //   //     await controller.getAvailableSlot();
          //   //     _showDialog(
          //   //     context,
          //   //     CupertinoPicker(
          //   //       itemExtent: 30.0,
          //   //       onSelectedItemChanged: controller.setSelectedStartTime,
          //   //       children: List<Widget>.generate(
          //   //         controller.availableSlot.length,
          //   //             (int index) => Center(child: Text(controller.availableSlot[index])),
          //   //       ),
          //   //     ),
          //   //   );},
          //   //   child: Text('Select Start Time'),
          //   // ),
          //
          //   // Start Time Button
          //     CupertinoButton(
          //       child: Text('${controller.availableSlot[controller.selectedStartIndex.value]}'),
          //       onPressed: () {
          //         _showDialog(
          //           context,
          //           CupertinoPicker(
          //             itemExtent: 30.0,
          //             onSelectedItemChanged: (int index) {
          //               controller.selectedStartIndex.value = index;
          //               if (controller.selectedEndIndex.value <= controller.selectedStartIndex.value) {
          //                 controller.selectedEndIndex.value = controller.selectedStartIndex.value + 1;
          //               }
          //               print(controller.availableSlot.value[index]);
          //             },
          //             children: List<Widget>.generate(controller.availableSlot.length, (int index) {
          //               return Center(child: Text(controller.availableSlot[index]));
          //             }),
          //           ),
          //         );
          //       },
          //     ),
          //
          //
          //   // // End Time Button
          //   // CupertinoButton(
          //   //   child: Text("Select End Time"),
          //   //   onPressed: () {
          //   //     _showDialog(
          //   //       context,
          //   //       Obx(() => CupertinoPicker(
          //   //         itemExtent: 30.0,
          //   //         onSelectedItemChanged: (int index) {
          //   //           controller.selectedEndIndex.value = index;
          //   //           if (controller.selectedEndIndex <= controller.selectedStartIndex.value) {
          //   //             controller.selectedStartIndex.value = controller.selectedEndIndex.value - 1;
          //   //           }
          //   //         },
          //   //         children: List<Widget>.generate(controller.availableSlots.length, (int index) {
          //   //           return Center(child: Text(controller.availableSlots[index]));
          //   //         }),
          //   //       )),
          //   //     );
          //   //   },
          //   // ),
          // ],
        ),
      ),
    );
  }
}
