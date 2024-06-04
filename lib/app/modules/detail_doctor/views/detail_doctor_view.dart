import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'widgets/review_card.dart';
import '../../../routes/app_pages.dart';

import '../../../utils/constants/style_constants.dart';
import '../../../utils/styles/styles.dart';

import '../../../service/user_service.dart';
import '../../../service/video_call_service.dart';
import '../../../utils/constants/constants.dart';
import '../controllers/detail_doctor_controller.dart';

class DetailDoctorView extends GetView<DetailDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher'.tr),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Stack(children: [
        controller.obx((doctor) => Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  buildImage(secondaryColor,
                      doctorProfilePic: doctor!.doctorPicture!),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    doctor.doctorName!,
                    style: doctorNameStyle,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    doctor.doctorCategory!.categoryName!,
                    style: doctorCategoryStyle,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RatingBarIndicator(
                      rating: 4.5,
                      itemCount: 5,
                      itemSize: 20.0,
                      itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Styles.secondaryColor,
                          )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Biography'.tr,
                      style: titleTextStyle,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    doctor.doctorShortBiography!,
                    style: subTitleTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Review'.tr,
                        style: titleTextStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'View All'.tr,
                          style: TextStyle(color: Styles.secondaryColor),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: GetBuilder<DetailDoctorController>(
                      builder: (_) {
                        return ListView.builder(
                            itemCount: _.listReview.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ReviewCard(review: _.listReview[index]);
                            });
                      },
                    ),
                  )
                ]),
              ),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 2, 10, 2),
            decoration: BoxDecoration(
              color: mBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: controller.selectedDoctor.doctorPrice != null
                      ? Text(
                          '${controller.selectedDoctor.doctorPrice!} $currencySign',
                          style: priceNumberTextStyle.copyWith(
                            color: Styles.primaryColor,
                            fontSize: 14,
                          ))
                      : Text(
                          '0 $currencySign',
                          style: priceNumberTextStyle.copyWith(
                            color: Styles.primaryColor,
                            fontSize: 12,
                          ),
                        ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/consultation-date-picker',
                              arguments: [controller.selectedDoctor, null]);
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            color: Styles.primaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                color: Styles.secondaryColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Teacher Consultation'.tr,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Styles.secondaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (controller.selectedDoctor.availableForCall ?? false)
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
                        child: InkWell(
                          onTap: () async {
                            EasyLoading.show(
                                indicator: EasyLoading().indicatorWidget,
                                dismissOnTap: true,
                                status: "جاري الاتصال");
                            Get.log(
                                "doctor id ${controller.selectedDoctor.doctorId}");
                            Get.log(
                                "user id ${UserService().currentUser?.uid}");

                            var data =
                                await DoctorVideoCallService.sendVideoCall(
                                        callerUid:
                                            UserService().currentUser?.uid ??
                                                '',
                                        receiveUid: controller
                                                .selectedDoctor.doctorUserId ??
                                            '')
                                    .then((value) {
                              EasyLoading.dismiss();
                              return value;
                            }).catchError((e) {
                              EasyLoading.dismiss();
                              return null;
                            });
                            EasyLoading.dismiss();
                            print(data);
                            controller.selectedDoctor.doctorUserId == null
                                ? Get.snackbar("خطأ",
                                    " حدث خطأ ما المعلم غير متاح للاتصال الان")
                                : Get.toNamed(Routes.CALL, arguments: {
                                    'token': data['token'],
                                    'room': data['channelName'],
                                    // 'role': ClientRole.Broadcaster.index
                                  });

                            Get.log(data.toString());
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              color: Styles.primaryColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone_in_talk,
                                  color: Styles.secondaryColor,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    'Call Teacher'.tr,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Styles.secondaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  SizedBox.shrink(),
                InkWell(
                  onTap: () => controller.toChatDoctor(),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Styles.primaryColor,
                    ),
                    child: Icon(
                      Icons.message_rounded,
                      color: Styles.secondaryColor,
                    ),
                  ),
                ).paddingSymmetric(horizontal: 2),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// Builds Profile Image
Widget buildImage(Color color, {String doctorProfilePic = ''}) {
  final defaultImage = doctorProfilePic.isEmpty
      ? AssetImage('assets/images/user.png')
      : NetworkImage(doctorProfilePic);

  return Container(
    child: CircleAvatar(
      radius: 74,
      backgroundColor: Styles.primaryColor,
      child: CircleAvatar(
        backgroundImage: defaultImage as ImageProvider,
        radius: 70,
      ),
    ),
  );
}
