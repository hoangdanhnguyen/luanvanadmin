import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/controllers/product_controller.dart';
import 'package:admin_luanvan/views/products_screen/components/product_dropdown.dart';
import 'package:admin_luanvan/views/products_screen/components/product_images.dart';
import 'package:admin_luanvan/views/widget/custom_textfield.dart';
import 'package:admin_luanvan/views/widget/loading_indicator.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductsController>();

    return Obx(
      () =>Scaffold(
        backgroundColor: darkGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: white)
          ),
          title: boldText(text: "Add Product", color: lightGrey, size: 16.0),
          actions: [
            controller.isLoading.value ? loadingIndicator(cicleColor: white) : TextButton(
              onPressed: () async {
                controller.isLoading(true);
                await controller.uploadImage();
                await controller.uploadProduct(context);
                Get.back();
              },
              child: boldText(text: save, color: lightGrey)
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(hint: "name", label: "Product name", controller: controller.pnameController),
                10.heightBox,
                customTextField(hint: "desc", label: "Description", isDesc: true, controller: controller.pdescController),
                10.heightBox,
                customTextField(hint: "price", label: "Price", controller: controller.ppriceController),
                 10.heightBox,
                 customTextField(hint: "material", label: "Material", controller: controller.pmaterialController),
                10.heightBox,
                customTextField(hint: "quantity", label: "Quantity", controller: controller.pquantityControllerS),
                // 10.heightBox,
                // customTextField(hint: "quantity", label: "Quantity size M", controller: controller.pquantityControllerM),
                // 10.heightBox,
                // customTextField(hint: "quantity", label: "Quantity size L", controller: controller.pquantityControllerL),
                // 10.heightBox,
                // customTextField(hint: "quantity", label: "Quantity size XL", controller: controller.pquantityControllerXL),
                //  10.heightBox,
                // customTextField(hint: "quantity", label: "Quantity size XXL", controller: controller.pquantityControllerXXL),
                10.heightBox,
                productDropdown("Category", controller.categoryList, controller.categoryvalue, controller),
                10.heightBox,
                productDropdown("Subcategory", controller.subcategoryList, controller.subcategoryvalue, controller),
                10.heightBox,
                const Divider(color: white),
                boldText(text: "Choose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(3, (index) => controller.pImagesList[index] != null
                    ? Image.file(
                      controller.pImagesList[index], 
                      width: 100,
                      ).onTap(() {
                        controller.pickImage(index, context);
                      })
                    : productImages(label: "${index +1}").onTap(() {
                      controller.pickImage(index, context);
                    })
                  ),
                  ),
                ),
                10.heightBox,
                normalText(text: "First image will be your display image", color: lightGrey),

                10.heightBox,
                boldText(text: "Choose product colors"),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(7, (index) => Stack(
                      alignment: Alignment.center,
                      children: [
                        VxBox().color(Vx.randomPrimaryColor).roundedFull.size(65, 65).make().onTap(() {
                          controller.selectedCorlorIndex.value = index;
                        }),
                        controller.selectedCorlorIndex.value == index
                        ? const Icon(Icons.done, color: white)
                        : const SizedBox(),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}