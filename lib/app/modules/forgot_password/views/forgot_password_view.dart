import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../utils/styles/styles.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormBuilderState>();
    TextEditingController email = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password'.tr,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reset Password.?'.tr,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter Email address associated with your account'.tr,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 25,
              ),
              FormBuilder(
                key: formKey,
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email'.tr,
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Styles.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                  ),
                  cursorColor: Styles.primaryColor,
                  validator: (value) {
                    if (value == '' || value!.isEmpty) {
                      return 'emailRequired'.tr;
                    } else if (value != '' && !EmailValidator.validate(value)) {
                      return "invalidEmail".tr;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                  onTap: () {
                    formKey.currentState!.save();
                    if (formKey.currentState!.validate()) {
                      controller.resetPassword(email.text);
                    } else {
                      // controller.roundedBtnController.error();
                      print(Error());
                    }
                  },
                  child: Container(
                    width: 340,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green),
                    child: Text(
                      'Reset Password'.tr,
                      style: TextStyle(color: Styles.secondaryColor),
                    ),
                  ))
              // RoundedLoadingButton(
              //   // resetAfterDuration: true,
              //   // // color: Styles.primaryColor,
              //   // successColor: Colors.green,
              //   // resetDuration: Duration(seconds: 7),
              //   child: Text('Reset Password'.tr,
              //       style: TextStyle(color: Styles.secondaryColor)),
              //   controller: controller.roundedBtnController,
              //   onPressed: () {
              //     formKey.currentState!.save();
              //     if (formKey.currentState!.validate()) {
              //       controller.resetPassword(email.text);
              //     } else {
              //       controller.roundedBtnController.error();
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
