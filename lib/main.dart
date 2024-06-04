import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'app/service/bindings.dart';
import 'app/service/dynamic_links.dart';
import 'app/service/notification_service.dart';
import 'app/service/payment_service.dart';
import 'app/service/user_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/routes/app_pages.dart';
import 'app/service/firebase_service.dart';
import 'app/utils/localization.dart';
import 'app/utils/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {});
  await dotenv.load();
  await Firebase.initializeApp();
  Get.put<NotificationService>(NotificationService());
  Get.put(PaymentService);
  Get.put(UserService());
  Get.put(DynamicLinkService());
  bool isUserLogin = await FirebaseService().checkUserAlreadyLogin();
  initializeDateFormatting('ar', null);
  FirebaseChatCore.instance.setConfig(FirebaseChatCoreConfig(
    null,
    'Rooms',
    'Users',
  ));
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Talaam Student",
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Almarai",
        colorSchemeSeed: Styles.primaryColor,
        appBarTheme: AppBarTheme(
          titleTextStyle: Styles.appBarTextStyle,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      initialRoute: isUserLogin ? AppPages.DASHBOARD : AppPages.LOGIN,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      initialBinding: InitialBindings(),
      localizationsDelegates: [FormBuilderLocalizations.delegate],
      locale: LocalizationService.locale,
      translations: LocalizationService(),
    ),
  );
}
