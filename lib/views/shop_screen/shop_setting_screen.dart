import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/controllers/profile_controller.dart';
import 'package:admin_luanvan/views/widget/custom_textfield.dart';
import 'package:admin_luanvan/views/widget/loading_indicator.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';
import 'package:get/get.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(() => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isLoading.value 
            ? loadingIndicator(cicleColor: white) 
            : TextButton(onPressed: () async {
              controller.isLoading(true);
              await controller.updateShop(
                shopname: controller.shopNameController.text,
                shopaddress: controller.shopAddressController.text,
                shopmobile: controller.shopMobileController.text,
                shopwebsite: controller.shopWebsiteController.text,
                shopdesc: controller.shopDescController.text,
              );
              // ignore: use_build_context_synchronously
              VxToast.show(context, msg: "Shop Updated");
            }, child: normalText(text: save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                label: shopname,
                hint: nameHint,
                controller: controller.shopNameController
              ),
              10.heightBox,
              customTextField(
                label: shopaddress,
                hint: shopAddressHint,
                controller: controller.shopAddressController
              ),
              10.heightBox,
              customTextField(
                label: shopmobile,
                hint: shopMobilehint,
                controller: controller.shopMobileController
              ),
              10.heightBox,
              customTextField(
                label: shopwebsite,
                hint: shopWebsiteHint,
                controller: controller.shopWebsiteController
              ),
              10.heightBox,
              customTextField(
                isDesc: true,
                label: description,
                hint: shopDescHint,
                controller: controller.shopDescController
              ),
            ],
          ),
        ),
      ),
    );
  }
}