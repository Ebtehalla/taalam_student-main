import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import '../../login/views/widgets/divider_or.dart';
import '../../login/views/widgets/label_button.dart';
import '../../login/views/widgets/title_app.dart';
import '../../widgets/submit_button.dart';
import '../../../utils/helpers/validation.dart';

import '../../../utils/styles/styles.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // navigation bar color
      statusBarColor:
          Theme.of(context).scaffoldBackgroundColor, // status bar color
    ));
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    return Scaffold(
      body: Container(
        height: height,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: controller.formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .1),
                  TitleApp(),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      node.nextFocus();
                    },
                    validator: ((value) {
                      if (value!.length < 6) {
                        return 'Name must be  6 or more characters'.tr;
                      } else {
                        return null;
                      }
                    }),
                    onSaved: (username) {
                      controller.username = username!;
                    },
                    decoration: InputDecoration(
                        hintText: 'Username'.tr,
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
                        fillColor: Colors.grey[100],
                        filled: true),
                    cursorColor: Styles.primaryColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      node.nextFocus();
                    },
                    validator: ((value) {
                      return Validation().validateEmail(value);
                    }),
                    onSaved: (email) {
                      controller.email = email!;
                    },
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
                        fillColor: Colors.grey[100],
                        filled: true),
                    cursorColor: Styles.primaryColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GetBuilder<RegisterController>(
                      builder: (controller) => TextFormField(
                            obscureText: controller.passwordVisible,
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              node.nextFocus();
                            },
                            validator: ((value) {
                              if (value!.length < 3) {
                                return 'Password must be more than four characters'
                                    .tr
                                    .tr;
                              } else {
                                return null;
                              }
                            }),
                            onSaved: (password) {
                              controller.password = password!;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                    controller.passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Styles.primaryColor),
                                onPressed: () {
                                  controller.passwordIconVisibility();
                                },
                              ),
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
                          )),
                  SizedBox(
                    height: 20,
                  ),
                  submitButton(
                      onTap: () {
                        controller.signUpUser();
                      },
                      text: 'Register Now'.tr),
                  SizedBox(height: height * .01),
                  DividerOr(),
                  Container(
                    width: Get.width,
                    height: 50,
                    child: SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        controller.loginGoogle();
                      },
                    ),
                  ),
                  LabelButton(
                    onTap: () {
                      Get.offAndToNamed("/login");
                    },
                    title: 'Already have an account ?'.tr,
                    subTitle: 'Login'.tr,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
