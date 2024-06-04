import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/style_constants.dart';
import 'package:intl/intl.dart';

import '../../../utils/styles/styles.dart';
import '../controllers/consultation_date_picker_controller.dart';

class ConsultationDatePickerView
    extends GetView<ConsultationDatePickerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chose Timeslot'.tr,
          style: Styles.appBarTextStyle,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Chose Date'.tr,
                style: titleTextStyle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: DatePicker(
                DateTime.now(),
                locale: 'ar',
                initialSelectedDate: DateTime.now(),
                daysCount: 10,
                selectionColor: Styles.primaryColor,
                selectedTextColor: Styles.secondaryColor,
                height: context.height * .1,
                onDateChange: (date) {
                  controller.updateScheduleAtDate(
                    date.day,
                    date.month,
                    date.year,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                'Chose Time'.tr,
                style: titleTextStyle,
              ),
            ),
            SizedBox(height: 10),
            GetBuilder<ConsultationDatePickerController>(
              builder: (controller) => Expanded(
                child: (controller.timeSlotCount ?? 0) > 0
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: controller.obx(
                          (timeSlot) => GridView.builder(
                            padding: EdgeInsets.all(10),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: timeSlot!.length,
                            itemBuilder: (BuildContext ctx, index) {
                              var timeStartFormat = DateFormat.Hm()
                                  .format(timeSlot[index].timeSlot!);
                              var timeEnd = timeSlot[index].timeSlot!.add(
                                  Duration(minutes: timeSlot[index].duration!));
                              var timeEndFormat =
                                  DateFormat.Hm().format(timeEnd);
                              if (timeSlot[index].available!) {
                                return InkWell(
                                  onTap: () {
                                    controller.selectedTimeSlot.value =
                                        timeSlot[index];
                                  },
                                  child: Obx(
                                    () => Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '$timeStartFormat - $timeEndFormat${'\n Available'.tr}',
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      decoration:
                                          (controller.selectedTimeSlot.value ==
                                                  timeSlot[index])
                                              ? BoxDecoration(
                                                  color: Colors.green.shade500,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                )
                                              : BoxDecoration(
                                                  color: Styles.secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$timeStartFormat - $timeEndFormat${'\n Unavailable'.tr}',
                                    textAlign: TextAlign.center,
                                    style:
                                        GoogleFonts.nunito(color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                            "This teacher has no time slots available".tr)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  if (controller.selectedTimeSlot.value.timeSlotId == null) {
                    Fluttertoast.showToast(
                        msg: 'Please select time slot'.tr,
                        backgroundColor: Colors.white,
                        textColor: Colors.black);
                  } else {
                    controller.confirm();
                  }
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Styles.primaryColor,
                  ),
                  child: Text(
                    'Confirm'.tr,
                    style: TextStyle(
                      color: Styles.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
