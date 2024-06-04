import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constants/style_constants.dart';
import '../../../../utils/styles/styles.dart';

class DoctorCard extends StatelessWidget {
  final String doctorPhotoUrl;
  final String doctorName;
  final String doctorHospital;
  final String doctorPrice;
  final String doctorCategory;
  final VoidCallback onTap;
  final bool isOnline;
  const DoctorCard(
      {super.key,
      required this.isOnline,
      required this.doctorPhotoUrl,
      required this.doctorName,
      required this.doctorHospital,
      required this.doctorPrice,
      required this.doctorCategory,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, right: 15, left: 15),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 1, color: Colors.grey.shade100)),
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(doctorPhotoUrl)),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Price'.tr,
                        style: priceTextStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 10),
                        child: Text(
                          doctorPrice,
                          style: priceNumberTextStyle.copyWith(
                              color: Styles.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  doctorName,
                                  style: doctorNameStyle,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (isOnline)
                              TextWithIcon(
                                isOnline: true,
                                text: "Online".tr,
                                imageAsset: 'assets/icons/online.png',
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            TextWithIcon(
                              text: doctorCategory,
                              imageAsset: 'assets/icons/menu.png',
                            ),
                            SizedBox(height: 5),
                            TextWithIcon(
                              text: doctorHospital,
                              imageAsset: 'assets/icons/school.png',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RatingBarIndicator(
                                rating: 4.5,
                                itemCount: 5,
                                itemSize: 20,
                                itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Styles.secondaryColor,
                                    ))
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: onTap,
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Styles.primaryColor),
                          child: Text(
                            'Teacher Consultation'.tr,
                            style: TextStyle(color: Styles.secondaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  const TextWithIcon(
      {super.key,
      required this.text,
      required this.imageAsset,
      this.isOnline = false});

  final String text;
  final String imageAsset;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isOnline
            ? LottieBuilder.asset(
                "assets/icons/online.json",
                height: 20,
                width: 20,
              )
            : Image.asset(
                imageAsset,
                height: 20,
                width: 20,
              ),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
