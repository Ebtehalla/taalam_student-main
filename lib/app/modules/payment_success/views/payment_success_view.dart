import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/constants/style_constants.dart';
import '../../../utils/styles/styles.dart';
import '../controllers/payment_success_controller.dart';

class PaymentSuccessView extends GetView<PaymentSuccessController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Success'.tr),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness:
              Brightness.dark, // navigation bar color
          statusBarColor:
              Theme.of(context).scaffoldBackgroundColor, // status bar color
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                width: double.infinity,
                child: Lottie.asset('assets/animations/done.json',
                    height: 250,
                    repeat: false,
                    controller: controller.animController,
                    onLoaded: (composition) {
                  controller.animController.forward();
                })),
            Text(
              'Payment Successful'.tr,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.green),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Your payment has been processed! \n Details of transaction are included below'
                  .tr,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: mSubtitleColor),
              textAlign: TextAlign.center,
            ),
            Divider(
              height: 30,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('TOTAL AMOUNT PAID'.tr),
                  Text(currencySign + controller.price.value.toString())
                ],
              ),
            ),
            Divider(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('TRANSACTION DATE'.tr),
                Text(DateTime.now().toLocal().toString())
              ],
            ),
            Divider(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Meet link'.tr),
                InkWell(
                  onTap: (){
                    if (controller.link.value != ''){
                       final Uri uri = Uri.parse(controller.link.value);
                       launchUrl(uri);
                       Clipboard.setData(ClipboardData(text: controller.link.value));
                     } else {
                       Fluttertoast.showToast(
                         msg: 'error '.tr,
                         toastLength: Toast.LENGTH_LONG,
                       );
                     }
                  },
                  child: Text('Click here'.tr),
                ),
              ],
            ),
            Divider(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                controller.goHome();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Styles.primaryColor),
              child: Text(
                'Go Home'.tr,
                style: TextStyle(color: Styles.secondaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
