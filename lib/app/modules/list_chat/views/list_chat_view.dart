import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';

import '../../../models/doctor_model.dart';
import '../../../service/chat_service.dart';
import '../../../utils/styles/styles.dart';
import '../controllers/list_chat_controller.dart';

class ListChatView extends GetView<ListChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat'.tr,
          style: Styles.appBarTextStyle,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(orderByUpdatedAt: true),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData || (snapshot.data?.isEmpty ?? false)) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Text('The chat is empty'.tr),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final room = snapshot.data?[index];
              print('room : ${room?.imageUrl}');
              return _buildChatItem(room);
            },
          );
        },
      ),
    );
  }

  Widget _buildAvatar(String imgUrl) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(backgroundImage: NetworkImage(imgUrl), radius: 20),
    );
  }

  Widget _buildName(String name) =>
      Text(name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15));

  Widget _buildChatItem(types.Room? room) => FutureBuilder<Doctor>(
        future: ChatService().getDoctorByUserId(room?.users[1].id ?? ""),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return SizedBox();
          }
          return GestureDetector(
            onTap: () {
              Get.toNamed('/chat', arguments: [room, snapshot.data]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Row(
                children: [
                  _buildAvatar(snapshot.data?.doctorPicture ?? ""),
                  SizedBox(width: 6),
                  _buildName(snapshot.data?.doctorName ?? ""),
                ],
              ),
            ),
          );
        },
      );
}
