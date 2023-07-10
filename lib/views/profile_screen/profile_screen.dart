import 'package:admin_luanvan/controllers/auth_controller.dart';
import 'package:admin_luanvan/controllers/profile_controller.dart';
import 'package:admin_luanvan/services/store_services.dart';
import 'package:admin_luanvan/views/auth_screen/login_screen.dart';
import 'package:admin_luanvan/views/message_screen/message_screen.dart';
import 'package:admin_luanvan/views/profile_screen/edit_profile_screen.dart';
import 'package:admin_luanvan/views/shop_screen/shop_setting_screen.dart';
import 'package:admin_luanvan/views/widget/loading_indicator.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';
import 'package:admin_luanvan/const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());
    
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(onPressed: () {
            Get.to(()=> EditProfileScreen(
             username: controller.snapshotData['vendor_name'], 
            ));
          }, icon: const Icon(Icons.edit)),
          TextButton(onPressed: () async {
            await Get.find<AuthController>().signoutMethod(context);
            Get.offAll(() => const LoginSreen());
          }, child: normalText(text: logout))
        ],
      ),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator(cicleColor: white);
          } else {
            controller.snapshotData = snapshot.data!.docs[0];
            return Column(
                children: [
                  ListTile(
                    leading: controller.snapshotData['imageUrl'] == ''
                    ? Image.asset(imgAvatar, width: 100, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                    : Image.network(controller.snapshotData['imageUrl'], width: 100)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make(),
                    // leading: Image.asset(imgAvatar).box.roundedFull.clip(Clip.antiAlias).make(),
                    title: boldText(text: "${controller.snapshotData['vendor_name']}"),
                    subtitle: normalText(text: "${controller.snapshotData['email']}"),
                  ),
                  const Divider(),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(profileButtonIcons.length, (index) => ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(()=> const ShopSettings());
                              break;
                              case 1:
                              Get.to(()=> const MessageScreen());
                              break;
                            default:
                          }
                        },
                        leading: Icon(profileButtonIcons[index], color: white,),
                        title: normalText(text: profileButtonTitle[index]),
                      )
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}