import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../models/review_model.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});
  final ReviewModel review;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // navigation bar color
      statusBarColor:
          Theme.of(context).scaffoldBackgroundColor, // status bar color
    ));
    return Stack(
      children: [
        Container(
          height: 150,
          width: 200,
          padding: EdgeInsets.only(top: 30),
          child: Card(
            elevation: 3,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review.user!.displayName!),
                        RatingBarIndicator(
                            rating: 4.5,
                            itemCount: 5,
                            itemSize: 10.0,
                            itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ))
                      ],
                    ),
                  ],
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(review.review!),
                ))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            radius: 30,
            backgroundImage:
                review.user!.photoUrl == null || review.user!.photoUrl!.isEmpty
                    ? AssetImage('assets/images/user.png')
                    : NetworkImage(review.user!.photoUrl!) as ImageProvider,
          ),
        )
      ],
    );
  }
}
