import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/utils/constants/sizes_manager.dart';
import 'package:hallo_doctor_client/app/utils/extensions/num.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rich_text_view/rich_text_view.dart';
import '../../../models/post_model.dart';
import '../../../utils/styles/styles.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../controllers/posts_controller.dart';
import 'network_image.dart';
import 'progress_button.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class PostWidget extends GetView<PostsController> {
  const PostWidget({super.key, required this.index, required this.post});
  final int index;
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserWidget(post: post),
          PostTitle(post: post),
          if (post.imageUrl != null && post.imageUrl != '')
            ImageWidget(post: post).paddingSymmetric(horizontal: 10),
          if (post.user?.userId != controller.uid && post.user?.userId != null)
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: AppProgressButton(
                text: "تواصل مع مقدم الخدمة",
                fontSize: 14,
                backgroundColor: Styles.primaryColor,
                onPressed: (anim) async {
                  final otherUser = types.User(
                    id: post.user?.userId ?? "",
                    firstName: post.user?.displayName,
                    imageUrl: post.user?.photoUrl,
                  );
                  Room room =
                      await FirebaseChatCore.instance.createRoom(otherUser);
                  Get.toNamed(
                    '/chat',
                    arguments: [
                      room,
                      Doctor(
                        id: otherUser.id,
                        doctorName: post.user?.displayName,
                        doctorPicture: post.user?.photoUrl,
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    ).paddingSymmetric(horizontal: 8);
  }
}

class PostTitle extends StatelessWidget {
  const PostTitle({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextView(
            textDirection: TextDirection.ltr,
            text: post.title ?? '',
            selectable: true,
            viewMoreText: "see more",
            truncate: true,
            maxLines: 3,
            viewLessText: "see less",
            supportedTypes: const [],
            linkStyle: const TextStyle(color: Colors.blue),
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          Sizes.size4.h.heightSizedBox,
          Row(
            children: [
              Text(
                "سعر الإستشارة" " " ":",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Sizes.size4.w.widthSizedBox,
              Text(
                "من : ${post.minPrice ?? "0"} رس",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Sizes.size12.w.widthSizedBox,
              Text(
                "الي : ${post.maxPrice ?? "0"} رس",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class InteractionsWidget extends StatelessWidget {
  const InteractionsWidget({
    super.key,
    required this.post,
  });

  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              // Get.to(
              //   () => CommentsView(
              //     post: post,
              //   ),
              //   transition: Transition.downToUp,
              // );
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Styles.primaryColor.withOpacity(.05),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Iconsax.message,
                      color: Styles.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  (post.comments?.length ?? 0).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => CommentsView(
                  post: post,
                ),
                transition: Transition.downToUp,
              );
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Styles.primaryColor.withOpacity(.05),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Iconsax.message,
                      color: Styles.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  (post.comments?.length ?? 0).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  CommentsView({required PostModel post}) {}
}

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          // Get.toNamed(Routes.OTHER_PROFILE,
          //     arguments: {'userId': post.user?.uid});
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Styles.primaryColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              post.user?.photoUrl ?? "",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Iconsax.user,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
      title: GestureDetector(
        onTap: () {
          // Get.toNamed(Routes.OTHER_PROFILE,
          //     arguments: {'userId': post.user?.uid});
        },
        child: Text(
          post.user?.displayName ?? "username",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      subtitle: Text(
        timeago.format(
          post.createdAt!,
          locale: 'en',
        ),
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AppCashedImage(
        imageUrl: post.imageUrl ?? "",
        width: context.width,
      ),
    );
  }
}
