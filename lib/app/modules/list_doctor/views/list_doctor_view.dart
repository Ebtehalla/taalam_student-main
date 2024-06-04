import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'widgets/list_doctor_card.dart';
import 'widgets/tabbar.dart';
import '../../widgets/empty_list.dart';
import '../../../service/doctor_service.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/styles/styles.dart';

import '../../../models/doctor_model.dart';
import '../controllers/list_doctor_controller.dart';

class ListDoctorView extends GetView<ListDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Teacher'.tr,
          style: Styles.appBarTextStyle,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        child: TabBarAndTabViews(
          tabPairs: [
            TabPair(
                tab: Tab(
                  child: Text("All Teachers".tr),
                ),
                view: AllDoctorsList()),
            TabPair(
                tab: Tab(
                  child: Text(
                    "Online Teachers".tr,
                  ),
                ),
                view: FutureBuilder<List<Doctor>>(
                  future: DoctorService()
                      .getListOnlineDoctorByCategory(controller.doctorCategory),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Doctor> onlineDoctors = snapshot.data ?? [];
                      if (onlineDoctors.isEmpty) {
                        return Center(
                          child: Text("No Online Teachers".tr),
                        );
                      }
                      return ListView.builder(
                        itemCount: onlineDoctors.length,
                        itemBuilder: (context, index) => DoctorCard(
                            isOnline: true,
                            doctorPhotoUrl:
                                onlineDoctors[index].doctorPicture ?? '',
                            doctorName: onlineDoctors[index].doctorName ?? '',
                            doctorHospital:
                                onlineDoctors[index].doctorHospital ?? '',
                            doctorPrice:
                                "${onlineDoctors[index].doctorPrice} $currencySign",
                            doctorCategory: onlineDoctors[index]
                                    .doctorCategory
                                    ?.categoryName ??
                                '',
                            onTap: () {
                              Get.toNamed('/detail-doctor',
                                  arguments: onlineDoctors[index]);
                            }),
                      );
                    } else {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}

class AllDoctorsList extends GetWidget<ListDoctorController> {
  const AllDoctorsList({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: controller.obx(
            (listDoctor) => ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: listDoctor!.length,
                  itemBuilder: (context, index) {
                    return DoctorCard(
                        isOnline: false,
                        doctorName: listDoctor[index].doctorName!,
                        doctorCategory:
                            listDoctor[index].doctorCategory!.categoryName!,
                        doctorPrice:
                            "${listDoctor[index].doctorPrice} $currencySign",
                        doctorPhotoUrl: listDoctor[index].doctorPicture!,
                        doctorHospital: listDoctor[index].doctorHospital!,
                        onTap: () {
                          Get.toNamed('/detail-doctor',
                              arguments: listDoctor[index]);
                        });
                  },
                ),
            onLoading: CupertinoActivityIndicator(),
            onEmpty: Center(
                child: EmptyList(
                    msg: 'No Teacher Registered in this Category'.tr))),
      )
    ]);
  }
}
