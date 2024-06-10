import 'package:get/get.dart';
import '../../../models/doctor_model.dart';
import '../../../models/order_detail_model.dart';
import '../../../models/time_slot_model.dart';
import '../../../routes/app_pages.dart';
import '../../../service/notification_service.dart';
import '../../../service/payment_service.dart';
import '../../../service/user_service.dart';
import '../../../utils/constants/constants.dart';
import 'package:intl/intl.dart';

class DetailOrderController extends GetxController {
  final username = ''.obs;
  final UserService userService = Get.find();
  List<OrderDetailModel> orderDetail = List.empty();
  TimeSlot selectedTimeSlot = Get.arguments[0];
  Doctor doctor = Get.arguments[1];
  PaymentService paymentService = Get.find<PaymentService>();
  NotificationService notificationService = Get.find<NotificationService>();
  late String clientSecret;
  @override
  void onInit() {
    super.onInit();
    userService.getUsername().then((value) {
      username.value = value;
    });
  }

  @override
  void onClose() {}

  OrderDetailModel buildOrderDetail() {
    var formatter = DateFormat('yyyy-MM-dd hh:mm');
    var time = formatter.format(selectedTimeSlot.timeSlot!);
    var link = '';

    var orderDetail = OrderDetailModel(
        itemId: selectedTimeSlot.timeSlotId!,
        itemName: 'Consultation with'.tr + doctor.doctorName!,
        time: time,
        duration: selectedTimeSlot.duration.toString() + ' minute'.tr,
        price: currencySign + selectedTimeSlot.price.toString(),
        link: link
    );
    return orderDetail;
  }

  void makePayment(num count) async {
    bool isSuccess =
        await Get.toNamed(Routes.PAYMENT, arguments: {"count": count});
    if (isSuccess) {
      Get.offNamed('/payment-success', arguments: selectedTimeSlot);
      notificationService
          .setNotificationAppointment(selectedTimeSlot.timeSlot!);
    }
  }
}
