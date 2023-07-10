import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/controllers/chat_controller.dart';
import 'package:admin_luanvan/services/store_services.dart';
import 'package:admin_luanvan/views/message_screen/components/chat_bubble.dart';
import 'package:admin_luanvan/views/widget/loading_indicator.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkGrey),
          onPressed: () {
            Get.back();
          },
        ),
        title: "${controller.friendName}"
            .text
            .color(darkGrey)
            .make(),
      ),
      body: Column(children: [
        Obx(
          () => controller.isLoading.value
              ? Center(
                  child: loadingIndicator(),
                )
              : Expanded(
                  child: StreamBuilder(
                  stream: StoreServices.getChatMessages(
                      controller.chatDocId.toString()),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: loadingIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child:
                            "Send a message...".text.color(darkGrey).make(),
                      );
                    } else {
                      return ListView(
                        children: snapshot.data!.docs
                            .mapIndexed((currentValue, index) {
                          var data = snapshot.data!.docs[index];
                          return Align(
                              alignment: data['uid'] == currentUser!.uid
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: chatBunnle(data));
                        }).toList(),
                      );
                    }
                  },
                )),
        ),
        10.heightBox,
        Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: controller.msgController,
              decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey))),
            )),
            IconButton(
                onPressed: () {
                  controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();
                },
                icon: const Icon(
                  Icons.send,
                  color: red,
                ).hide(),
              )
          ],
        )
            .box
            .height(80)
            .padding(const EdgeInsets.all(12))
            .margin(const EdgeInsets.only(bottom: 8))
            .make()
      ]),
    );
  }
}