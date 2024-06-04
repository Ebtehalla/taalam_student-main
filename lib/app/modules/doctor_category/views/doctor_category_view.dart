import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/constants/style_constants.dart';
import '../../../utils/styles/styles.dart';
import '../controllers/doctor_category_controller.dart';

class DoctorCategoryView extends GetView<DoctorCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        title: Text(
          'Teacher\'s specialties'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: controller.obx((listCategory) => GridView.builder(
                  itemCount: listCategory!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed('/list-doctor',
                            arguments: listCategory[index]);
                      },
                      child: Container(
                          child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Styles.secondaryColor),
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                                imageUrl: listCategory[index].iconUrl!),
                          )),
                          SizedBox(
                            height: 5,
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              listCategory[index].categoryName!,
                              style: doctorCategoryTextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          )
                        ],
                      )),
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
