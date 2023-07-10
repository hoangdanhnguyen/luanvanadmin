import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';
import 'package:get/get.dart';
import 'package:admin_luanvan/views/products_screen/product_popup_screen.dart';

class ProductDetails1 extends StatelessWidget {
  final dynamic data;
  const ProductDetails1({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black)
        ),
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // VxSwiper.builder(
            //   autoPlay: true,
            //   height: 350,
            //   itemCount: data['p_imgs'].length,
            //   aspectRatio: 16 / 9,
            //   viewportFraction: 1.0,
            //   itemBuilder: (context, index) {
            //     return Image.network(
            //       data['p_imgs'][index],
            //       width: double.infinity,
            //       fit: BoxFit.cover,
            //     );
            //   }
            // ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Size S", color: fontGrey)
                          ),
                          normalText(text: "${data['p_quantity_s']} items", color: fontGrey)
                        ],
                      ),

                      10.heightBox,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Size M", color: fontGrey)
                          ),
                          normalText(text: "${data['p_quantity_m']} items", color: fontGrey)
                        ],
                      ),

                      10.heightBox,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Size L", color: fontGrey)
                          ),
                          normalText(text: "${data['p_quantity_l']} items", color: fontGrey)
                        ],
                      ),

                      10.heightBox,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Size XL", color: fontGrey)
                          ),
                          normalText(text: "${data['p_quantity_xl']} items", color: fontGrey)
                        ],
                      ),

                      10.heightBox,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Size XXL", color: fontGrey)
                          ),
                          normalText(text: "${data['p_quantity_xxl']} items", color: fontGrey)
                        ],
                      ),


                    ],
                  ).box.white.padding(const EdgeInsets.all(8.0)).shadowSm.make(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}