import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../list_doctor/views/widgets/list_doctor_card.dart';
import '../../widgets/empty_list.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/styles/styles.dart';

import '../controllers/top_rated_doctor_controller.dart';

class TopRatedDoctorView extends GetView<TopRatedDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Rated Teacher'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: controller.obx(
                (listDoctor) => ListView.builder(
                      padding: EdgeInsets.only(top: 10.0),
                      itemCount: listDoctor!.length,
                      itemBuilder: (context, index) {
                        return DoctorCard(
                            isOnline:
                                listDoctor[index].availableForCall ?? false,
                            doctorName: listDoctor[index].doctorName!,
                            doctorCategory:
                                listDoctor[index].doctorCategory!.categoryName!,
                            doctorPrice: currencySign +
                                listDoctor[index].doctorPrice.toString(),
                            doctorPhotoUrl: listDoctor[index].doctorPicture!,
                            doctorHospital: listDoctor[index].doctorHospital!,
                            onTap: () {
                              Get.toNamed('/detail-doctor',
                                  arguments: listDoctor[index]);
                            });
                      },
                    ),
                onEmpty: Center(
                    child: EmptyList(
                        msg: 'No Teacher Registered in this Category'.tr))),
          )
        ]),
      ),
    );
  }
}
