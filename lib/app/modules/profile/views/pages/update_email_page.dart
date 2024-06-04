import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../utils/styles/styles.dart';
import '../../../widgets/submit_button.dart';
import '../../controllers/profile_controller.dart';

class UpdateEmailPage extends GetView<ProfileController> {
  final _formKey = GlobalKey<FormBuilderState>();

  UpdateEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Update Email'.tr,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'What\'s Your New Email Address?'.tr,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                    child: FormBuilderTextField(
                      // Handles Form Validation for First Name
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Name must be more than two characters'.tr;
                        } else if (value != '' &&
                            !EmailValidator.validate(value)) {
                          return 'Enter a valid mail address'.tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'New Email Address'.tr,
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black87),
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
                      name: 'email',
                      keyboardType: TextInputType.emailAddress,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: submitButton(
                      onTap: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          controller.updateEmail(
                              _formKey.currentState!.value['email']);
                        } else {
                          print("validation failed");
                        }
                      },
                      text: 'Save'.tr),
                )
              ],
            ),
          ),
        ));
  }
}
