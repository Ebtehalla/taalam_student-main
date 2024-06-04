import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/icons/MyStudent_icons.dart';
import '../../../utils/styles/styles.dart';
import '../../Posts/views/posts_view.dart';
import '../../appointment/views/appointment_view.dart';
import '../../doctor_category/views/doctor_category_view.dart';
import '../../home/views/home_view.dart';
import '../../list_chat/views/list_chat_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final List<Widget> bodyContent = [
    HomeView(),
    DoctorCategoryView(),
    AppointmentView(),
    PostsView(),
    ListChatView(),
    ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Styles.secondaryColor,
          unselectedItemColor: Colors.black54,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                MyStudent.home_2,
              ),
              label: "Home".tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MyStudent.element_3,
              ),
              label: "Specialties".tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MyStudent.video,
              ),
              label: "Appointment".tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MyStudent.video,
              ),
              label: "الإستشارات",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MyStudent.message,
              ),
              label: "Chat".tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MyStudent.profile,
              ),
              label: "Profile".tr,
            ),
          ],
          currentIndex: controller.selectedIndex,
          onTap: (index) {
            controller.selectedIndex = index;
          },
        ),
      ),
      body: Obx(
        () => Center(
          child: IndexedStack(
            index: controller.selectedIndex,
            children: bodyContent,
          ),
        ),
      ),
    );
  }
}
