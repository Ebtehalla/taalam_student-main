import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/style_constants.dart';
import '../../../../utils/styles/styles.dart';

class DoctorCard extends StatelessWidget {
  final String? doctorName;
  final String? doctorSpecialty;
  final String? imageUrl;
  final VoidCallback onTap;
  const DoctorCard(
      {super.key,
      this.doctorName,
      this.doctorSpecialty,
      this.imageUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.maxFinite,
            padding: EdgeInsets.fromLTRB(18, 3, 18, 3),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        imageUrl!,
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          doctorName!,
                          style: doctorNameTextStyle,
                        ),
                      ),
                      Text(
                        doctorSpecialty!,
                        style: specialistTextStyle,
                      ),
                      RatingBarIndicator(
                          rating: 4.5,
                          itemCount: 5,
                          itemSize: 20.0,
                          itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Styles.secondaryColor,
                              ))
                    ],
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: onTap,
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Styles.primaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            "Teacher Consultation".tr,
                            style: TextStyle(
                                color: Styles.secondaryColor,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
