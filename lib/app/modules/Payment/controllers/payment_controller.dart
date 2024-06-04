import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

class PaymentController extends GetxController {
  num count = 0;
  @override
  void onInit() {
    count = Get.arguments["count"];
    log(count.toString());
    MFSDK.init(
      "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
      MFCountry.SAUDIARABIA,
      MFEnvironment.TEST,
    );
    super.onInit();
  }

  String paymentId = "";

  Future<MFGetPaymentStatusResponse?> getPaymentStatus(int invoiceId) async {
    final MFGetPaymentStatusResponse mfGetPaymentStatusResponse;
    MFGetPaymentStatusRequest request = MFGetPaymentStatusRequest(
      key: "$invoiceId",
      keyType: MFKeyType.INVOICEID,
    );
    try {
      mfGetPaymentStatusResponse =
          await MFSDK.getPaymentStatus(request, MFLanguage.ARABIC);
      return mfGetPaymentStatusResponse;
    } on MFError catch (e) {
      // BotToast.showText(text: e.message ?? "");
      log(e.code.toString());
      return null;
    }
  }

  Future<MFSendPaymentResponse?> sendPaymentNotification(
    int total,
  ) async {
    final MFSendPaymentResponse mfInitiatePaymentResponse;
    MFSendPaymentRequest request = MFSendPaymentRequest();
    request.customerName = "test";
    request.invoiceValue = total;
    request.customerEmail = "email@test.com";
    request.notificationOption = MFNotificationOption.EMAIL;
    try {
      mfInitiatePaymentResponse = await MFSDK.sendPayment(
        request,
        MFLanguage.ARABIC,
      );
      return mfInitiatePaymentResponse;
    } on MFError catch (e) {
      // BotToast.showText(text: e.message ?? "");
      log(e.code.toString());
      return null;
    }
  }

  Future<(List<MFPaymentMethod>?, MFError?)?> initiatePayment(num total) async {
    try {
      MFError? error;
      List<MFPaymentMethod>? paymentMethods;
      final MFInitiatePaymentResponse mfInitiatePaymentResponse;
      MFInitiatePaymentRequest request = MFInitiatePaymentRequest(
        invoiceAmount: total,
        currencyIso: MFCurrencyISO.SAUDIARABIA_SAR,
      );
      try {
        mfInitiatePaymentResponse =
            await MFSDK.initiatePayment(request, MFLanguage.ARABIC);
        paymentMethods = mfInitiatePaymentResponse.paymentMethods;
      } on MFError {
        rethrow;
        //  error = e;
        // BotToast.showText(text: " ${e.code} ${e.message}" ?? "");
        // log(e.code.toString());
      }
      return (paymentMethods, error);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<(MFGetPaymentStatusResponse?, MFError?)> executePayment(
    num total,
    int paymentMethodId,
  ) async {
    MFGetPaymentStatusResponse? executePaymentRequest;
    MFError? error;
    MFExecutePaymentRequest request = MFExecutePaymentRequest(
        invoiceValue: total,
        paymentMethodId: paymentMethodId,
        customerEmail: "email@test.com",
        customerMobile: "01234567891",
        customerName: "test",
        language: MFLanguage.ARABIC,
        displayCurrencyIso: MFCurrencyISO.SAUDIARABIA_SAR);
    try {
      executePaymentRequest = await MFSDK.executePayment(
        request,
        MFLanguage.ARABIC,
        (invoiceId) {
          debugPrint(invoiceId);
        },
      ).then((value) {
        paymentId = value.invoiceTransactions?[0].paymentId ??
            "PAYMENT_ID NOT AVAILABLE";
        return value;
      });
    } on MFError catch (e) {
      error = e;
    }
    return (executePaymentRequest, error);
  }
}

String getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'MF001':
      return 'فشل التحقق الثلاثي الأبعاد (3DS). الأسباب الممكنة: إدخال مستخدم كلمة مرور خاطئة، العميل/المصدر غير مسجلين في 3DS، أو لدى بنك الإصدار مشكلة تقنية.';
    case 'MF002':
      return 'رفض بنك الإصدار للمعاملة. الأسباب الممكنة: بيانات بطاقة غير صحيحة، أموال غير كافية، تم رفضه بواسطة التقييم المخاطري، انتهت صلاحية البطاقة/تم تعليقها، أو البطاقة غير ممكنة للشراء عبر الإنترنت.';
    case 'MF003':
      return 'تم منع المعاملة من البوابة. الأسباب الممكنة: BIN البطاقة غير مدعوم، اكتشاف الاحتيال، أو قواعد منع الأمان.';
    case 'MF004':
      return 'أموال غير كافية';
    case 'MF005':
      return 'انتهت مهلة الجلسة';
    case 'MF006':
      return 'تم إلغاء المعاملة';
    case 'MF007':
      return 'انتهت صلاحية البطاقة.';
    case 'MF008':
      return 'البنك المصدر لا يستجيب.';
    case 'MF009':
      return 'تم الرفض بواسطة التقييم المخاطري';
    case 'MF010':
      return 'رمز الأمان خاطئ';
    default:
      return 'فشل غير محدد';
  }
}
