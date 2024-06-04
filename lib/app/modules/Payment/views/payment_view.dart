import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/utils/styles/styles.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import '../controllers/payment_controller.dart';
import '../widgets/progress_button.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدفع'),
        centerTitle: true,
      ),
      body: FutureBuilder<(List<MFPaymentMethod>?, MFError?)?>(
        future: controller.initiatePayment(controller.count),
        builder: (context, snapshot) {
          log(snapshot.toString());
          if (snapshot.hasData) {
            (List<MFPaymentMethod>?, MFError?)? paymentMethods = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                  children: (paymentMethods?.$1 ?? [])
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppProgressButton(
                            backgroundColor: Styles.secondaryColor,
                            onPressed: (anim) async {
                              (
                                MFGetPaymentStatusResponse?,
                                MFError?
                              ) paymentStatusResponse =
                                  await controller.executePayment(
                                controller.count,
                                e.paymentMethodId ?? 0,
                              );
                              Get.log(paymentStatusResponse.$2.toString());
                              if (paymentStatusResponse.$2 != null) {
                                // EasyLoading.showText(
                                //     text: paymentStatusResponse.$2?.message ??
                                //         "");
                                return;
                              }
                              Get.back(result: true);
                              // await controller.paymentSuccess();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    " ${e.paymentMethodAr} ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Image.network(e.imageUrl ?? ""),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("فشل انشاء الدفع ${snapshot.error}"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
