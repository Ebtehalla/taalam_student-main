import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/posts_services.dart';
import 'package:hallo_doctor_client/app/utils/styles/styles.dart';

import '../../../models/post_model.dart';
import '../controllers/posts_controller.dart';
import '../widgets/post_widget.dart';
import 'add_post_screen.dart';

class PostsView extends GetView<PostsController> {
  const PostsView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('الإستشارات'),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: () {
                  Get.to(() => AddPostScreen());
                },
                child: Text(
                  "إضافة إستشارة",
                  style: Styles.homeSubTitleStyle,
                ),
              ),
            ],
          ),
          body: RefreshIndicator.adaptive(
            onRefresh: () async {
              Get.forceAppUpdate();
            },
            child: FutureBuilder(
              future: PostService().getAllUserPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  controller.posts.clear();
                  snapshot.data?.docs.map((e) {
                    controller.posts.add(PostModel.fromMap(e.data()));
                  }).toList();
                  return AnimationLimiter(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          controller.posts.length,
                          (index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              child: ScaleAnimation(
                                child: PostWidget(
                                  index: index,
                                  post: controller.posts[index],
                                ).paddingSymmetric(vertical: 8),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          ),
        );
      },
    );
  }
}
