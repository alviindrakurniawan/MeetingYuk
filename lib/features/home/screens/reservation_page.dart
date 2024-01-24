import 'package:MeetingYuk/features/home/view_model/dasboard_viewmodel.dart';
import 'package:MeetingYuk/features/home/view_model/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MeetingYuk/features/home/view_model/reservation_viewmodel.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ReservationPage extends GetView<ReservationViewModel> {
  const ReservationPage({Key? key}) : super(key: key);

  Future<void> _showStartTimePicker(BuildContext context) {
    int tempSelectedIndexStart = controller.startTimeIndex.value;
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: Column(
            children: <Widget>[
              // Buttons at the top
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: TextButton(
                      child: Text('Cancel', style: mediumRed16),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: TextButton(
                      child: Text('Save', style: mediumPrim16),
                      onPressed: () async {
                        print(tempSelectedIndexStart);
                        if (tempSelectedIndexStart !=
                            controller.startTimeIndex.value) {
                          controller.startTimeIndex.value =
                              tempSelectedIndexStart;
                          controller.startTime.value =
                              controller.availableSlots[tempSelectedIndexStart];
                          print(controller.startTimeIndex.value);
                          print(controller.startTime.value);

                          // reset endTime when starttime before endtime
                          if (controller.endTime.value != null &&
                              controller.endTime.value!
                                  .isBefore(controller.startTime.value!)) {
                            controller.endTimeIndex.value = 0;
                            controller.endTime.value = null;
                          }
                          //update total price
                          if (controller.startTime.value != null &&
                              controller.endTime.value != null) {
                            controller.calculateTotalPrice();
                          }

                          //reset end button or minus index end same as start

                          //create list for endtime button
                          controller.availableSlotsEnd.value =
                              List.from(controller.availableSlots);
                          DateTime last = controller.availableSlotsEnd.last
                              .add(Duration(minutes: 15));
                          print(last);
                          controller.availableSlotsEnd.add(last);
                        }

                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
              // Picker below the buttons
              Expanded(
                child: CupertinoPicker(
                  onSelectedItemChanged: (value) {
                    tempSelectedIndexStart = value;
                  },
                  itemExtent: 40,
                  magnification: 1.2,
                  squeeze: 1.3,
                  scrollController: FixedExtentScrollController(
                      initialItem: controller.startTimeIndex.value),
                  useMagnifier: true,
                  children: List<Widget>.generate(
                      controller.availableSlots.length, (index) {
                    return Text(
                      DateFormat('HH:mm')
                          .format(controller.availableSlots[index]),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Future<void> showStartTimePicker(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext builder) {
  //       return Container(
  //         height: MediaQuery.of(context).copyWith().size.height / 3,
  //         child: CupertinoPicker(
  //           onSelectedItemChanged: (value) {
  //
  //               controller.startTimeIndex.value = value;
  //               controller.startTime.value = controller.availableSlots[value];
  //               print(controller.startTime.value );
  //
  //               if (controller.endTime.value != null && controller.endTime.value!.isBefore(controller.startTime.value!)) {
  //                 controller.endTime.value = null;
  //               }
  //
  //           },
  //           itemExtent: 45,
  //           magnification: 1.2,
  //           squeeze: 1.5,
  //           useMagnifier: true,
  //           children: List<Widget>.generate(controller.availableSlots.length, (index) {
  //             return Text(DateFormat('HH:mm').format(controller.availableSlots[index]),style: TextStyle(fontWeight: FontWeight.w500),);
  //           }),
  //         ),
  //       );
  //     },
  //   );
  // }
  Future<void> _showEndTimePicker(BuildContext context, List<DateTime> slots) {
    int tempSelectedIndexEnd = controller.endTimeIndex.value;
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: TextButton(
                      child: Text('Cancel', style: mediumRed16),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: TextButton(
                      child: Text('Save', style: mediumPrim16),
                      onPressed: () async {
                        if (tempSelectedIndexEnd !=
                            controller.startTimeIndex.value) {
                          controller.endTimeIndex.value = tempSelectedIndexEnd;
                          controller.endTime.value =
                              slots[tempSelectedIndexEnd];

                          //update total price
                          if (controller.startTime.value != null &&
                              controller.endTime.value != null) {
                            controller.calculateTotalPrice();
                          }
                        }

                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  onSelectedItemChanged: (value) {
                    tempSelectedIndexEnd = value;
                  },
                  itemExtent: 40,
                  magnification: 1.2,
                  squeeze: 1.3,
                  scrollController: FixedExtentScrollController(
                      initialItem: controller.endTimeIndex.value),
                  useMagnifier: true,
                  children: List<Widget>.generate(slots.length, (index) {
                    return Center(
                        child: Text(DateFormat('HH:mm').format(slots[index]),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            )));
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: blackColor,
              size: 18,
            ),
          ),
        ),
        body: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${controller.detailPlace.value!.rooms[controller.indexRoom.value].name}',
                style: boldPrim24,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Please select your date',
                style: regBlack14,
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 7, left: 45, right: 45, bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Select Date
                    GestureDetector(
                      onTap: () async {
                        controller.setNextAvailableDate(
                            controller.detailPlace.value!.openingHours);

                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now()
                              .add(Duration(days: 30)),
                          selectableDayPredicate: (DateTime date) =>
                              controller.isDayAvailable(date,
                                  controller.detailPlace.value!.openingHours),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: primaryColor,
                                ),
                                dialogBackgroundColor: Colors.white,
                                dialogTheme: const DialogTheme(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))),
                              ),
                              child: child!,
                            );
                          },
                        ).then((date) async {
                          if (date != null) {
                            print('check1');
                            await controller.setDateTime(date);
                            print('check2');
                            controller.activeButton.value = true;
                            // await
                            await controller.checkAvailability(
                                selected_date: DateFormat('yyyy-MM-dd')
                                    .format(controller.dateTime.value!));
                            print('check3');
                          } else {}
                          controller.resetStartEndPrice();
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 12, top: 6, right: 10, bottom: 6),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    offset: Offset(0, 3.0))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.calendar_today_rounded,
                                        size: 22,
                                        color: primaryColor,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 17,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Select a day',
                                        style: regularBlack12,
                                      ),
                                      Obx(
                                        () => controller.dateTime.value==null
                                            ? Text('',style: mediumBlack14,)
                                            : Text(
                                              "${DateFormat('dd MMMM yyyy').format(controller.dateTime.value!)}",
                                              style: mediumBlack14,
                                            ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 24,
                              )
                            ],
                          )),
                    ),
                    //Time
                    Row(
                      children: [
                        //Time start
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await _showStartTimePicker(context);
                            },
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 12, top: 6, right: 10, bottom: 6),
                                margin: EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          spreadRadius: 0,
                                          offset: Offset(0, 3.0))
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: 24,
                                          color: primaryColor,
                                        ),
                                        SizedBox(
                                          width: 17,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Start',
                                              style: regularBlack12,
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Obx(
                                              () => controller
                                                          .startTime.value ==
                                                      null
                                                  ? Text('-')
                                                  : Text(
                                                      '${DateFormat('HH:mm').format(controller.startTime.value!)}',
                                                      style: mediumBlack14,
                                                    ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 24,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        //Time end
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              List<DateTime> filteredSlots =
                                  controller.filterSlots();
                              await _showEndTimePicker(
                                  context, filteredSlots);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 12, top: 6, right: 10, bottom: 6),
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        offset: Offset(0, 3.0))
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        size: 24,
                                        color: primaryColor,
                                      ),
                                      SizedBox(
                                        width: 17,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'End',
                                            style: regularBlack12,
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Obx(
                                            () => controller.endTime.value ==
                                                    null
                                                ? Text('-')
                                                : Text(
                                                    '${DateFormat('HH:mm').format(controller.endTime.value!)}',
                                                    style: mediumBlack14,
                                                  ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 24,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: Offset(0, 1.0))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 15),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        controller: controller.addController,
                        textAlignVertical: TextAlignVertical.bottom,
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Padding(
                              padding:
                                  EdgeInsets.only(right: 20.0, left: 15.0),
                              child: Icon(
                                Icons.add,
                                color: grey,
                                size: 22,
                              ),
                            ),
                            hintText: 'Add Participant ID',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0))),
                        onSubmitted: (value) {
                          controller.addParticipant(id: value);
                        },
                      ),
                    ),
                    Obx(() => controller.participantName.isEmpty
                        ? Container()
                        : Container(
                          margin: EdgeInsets.only(top: 12),
                          height: 200,
                          child: ListView.builder(
                              itemCount: controller.participantName.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    // Remove the item from the list
                                    controller.participantName.removeAt(index);
                                    controller.participantId.removeAt(index);
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],

                                    ),
                                  ),
                                  child: Container(
                                    height: 55,
                                    margin: EdgeInsets.only(left: 8,right: 8,bottom: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10),),
                                      color: Colors.white,
                                      border: Border.all(width: 2,color: primaryColor)
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.person),
                                      title:
                                          Text(controller.participantName[index],style: mediumBlack14,),
                                    ),
                                  ),
                                );
                              },
                            ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() => controller.totalPrice.value != '-'
            ? BottomAppBar(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 12.5, bottom: 12.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('IDR ${controller.totalPrice.value}',
                          style: boldBlack20),
                      Container(
                          width: 170,
                          height: 35,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.reservationId.value != ''
                                    ? controller.updateReservation()
                                    : controller.createReservation();
                                // Get.delete<ReservationViewModel>;
                                // Get.offAndToNamed('/home');
                                Get.back();
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              child: controller.loading.value == false
                                  ? Text('Reserve', style: boldWhite14)
                                  : CircularProgressIndicator(
                                      color: Colors.white)))
                    ],
                  ),
                ),
              )
            : BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
              )));
  }
}
