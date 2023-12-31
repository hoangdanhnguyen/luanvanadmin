import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/services/store_services.dart';
import 'package:admin_luanvan/views/message_screen/chat_screen.dart';
import 'package:admin_luanvan/views/widget/loading_indicator.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'as intl;

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkGrey),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: message, size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
        stream: StoreServices.getMessages(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var t = data[index]['created_on'] == null ? DateTime.now() : data[index]['created_on'].toDate();
                    var time = intl.DateFormat("h:mm").format(t);
                    return ListTile(
                    onTap: () {
                      Get.to(()=> const ChatScreen(),
                      arguments: [
                                data[index]['friend_name'],
                                data[index]['fromId'],
                              ],);
                    },
                    leading: const CircleAvatar(
                      backgroundColor: purpleColor,
                      child: Icon(
                        Icons.person,
                        color: white,
                      )
                    ),
                    title: boldText(text: "${data[index]['sender_name']}", color: fontGrey),
                    subtitle: normalText(text: "${data[index]['last_msg']}", color: darkGrey),
                    trailing: normalText(text: time, color: darkGrey),
                  );
                  } ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}