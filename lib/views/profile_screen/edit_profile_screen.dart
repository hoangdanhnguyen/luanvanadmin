import 'dart:io';
import 'package:admin_luanvan/controllers/profile_controller.dart';
import 'package:admin_luanvan/views/widget/custom_textfield.dart';
import 'package:admin_luanvan/views/widget/loading_indicator.dart';
import 'package:get/get.dart';
import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: darkGrey,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isLoading.value
            ? loadingIndicator(cicleColor: white)
            : TextButton(onPressed: () async {
              controller.isLoading(true);
              if (controller.profileImgPath.value.isNotEmpty) {
                await controller.uploadProfileImage();
              } else {
                controller.profileImgLink = controller.snapshotData['imageUrl'];
              }
    
              if (controller.snapshotData['password'] == controller.oldpassController.text) {
                await controller.changeAuthPassword(
                  email: controller.snapshotData['email'],
                  password: controller.oldpassController.text,
                  newpassword: controller.newpassController.text
                );
                await controller.updateProfile(
                  imageUrl: controller.profileImgLink,
                  name: controller.nameController.text,
                  password: controller.newpassController.text
                );
                // ignore: use_build_context_synchronously
                VxToast.show(context, msg: "Updated");
              } else if (controller.oldpassController.text.isEmptyOrNull && controller.newpassController.text.isEmptyOrNull) {
                await controller.updateProfile(
                  imageUrl: controller.profileImgLink,
                  name: controller.nameController.text,
                  password: controller.snapshotData['password']
                );
                // ignore: use_build_context_synchronously
                VxToast.show(context, msg: "Updated");
              } else {
                // ignore: use_build_context_synchronously
                VxToast.show(context, msg: "Some error occured");
                controller.isLoading(false);
              }
            }, child: normalText(text: save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [
                controller.snapshotData['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(imgAvatar, width: 100, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                  : controller.snapshotData['imageUrl'] != '' && controller.profileImgPath.isEmpty
                  ? Image.network(
                    controller.snapshotData['imageUrl'],
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                  : Image.file(
                    File(controller.profileImgPath.value),
                    width: 100, 
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue
                  ),
                  onPressed: () {
                    controller.changeImage(context);
                  }, 
                  child: normalText(text: changeImage),
                ),
                10.heightBox,
                const Divider(color: white),
                10.heightBox,
                customTextField(label: name, hint: "Name", controller: controller.nameController),
                20.heightBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Change your password")
                ),
                10.heightBox,
                customTextField(label: password, hint: passwordHint, controller: controller.oldpassController),
                10.heightBox,
                customTextField(label: comfirmPassword, hint: passwordHint, controller: controller.newpassController),
              ],
            ),
          ),
      ),
    );
  }
}