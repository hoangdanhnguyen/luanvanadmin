import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/views/products_screen/product_popup_1.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';
import 'package:get/get.dart';
import 'package:admin_luanvan/views/products_screen/product_popup_screen.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

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
            VxSwiper.builder(
              autoPlay: true,
              height: 350,
              itemCount: data['p_imgs'].length,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              itemBuilder: (context, index) {
                return Image.network(
                  data['p_imgs'][index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: "${data['p_category']}", color: fontGrey, size: 16.0),
                      10.widthBox,
                      normalText(text: "${data['p_subcategory']}", color: fontGrey,size: 16.0),
                    ],
                  ),
                  // 10.heightBox,
                  //  Row(
                  //   children: [
                  //     boldText(text: "Material", color: fontGrey, size: 16.0),
                  //     10.widthBox,
                  //     normalText(text: "${data['p_material']}", color: fontGrey,size: 16.0),
                  //   ],
                  // ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),
                  10.heightBox,
                  boldText(text: "\$${data['p_price']}",color: red, size: 18.0),
                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Color", color: fontGrey),
                          ),
                          // Row(
                          //   children: List.generate(
                          //     3,
                          //     (index) => VxBox()
                          //         .roundedFull
                          //         .size(40, 40)
                          //         .color(Color(data['p_colors'][index]))
                          //         .margin(const EdgeInsets.symmetric(horizontal: 4))
                          //         .make()
                          //         .onTap(() {
                          //     //       Navigator.of(context).push(DialogRoute(
                          //     //         context: context,
                          //     //         builder: (context){
                          //     //           return const ProductDetails1();
                          //     //         }
                          //     //       )
                          //     // );
                          //     //Get.to(() => ProductDetails1(data: data[index]));
                          //     //Navigator.push(context, MaterialPageRoute(builder: builder))
                          //     }),
                          //   ),
                          // ),

                          Row(
                                children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Color(
                                                        data['p_colors'][index])
                                                    .withOpacity(1.0))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6))
                                                .make()
                                                .onTap(() {
                                             
                                            })
                                          ],
                                        )),
                              )

                        ],
                      ),
                      // 10.heightBox,
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 100,
                      //       child: boldText(text: "Size S", color: fontGrey)
                      //     ),
                      //     normalText(text: "${data['p_quantity_s']} items", color: fontGrey)
                      //   ],
                      // ),

                      // 10.heightBox,
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 100,
                      //       child: boldText(text: "Size M", color: fontGrey)
                      //     ),
                      //     normalText(text: "${data['p_quantity_m']} items", color: fontGrey)
                      //   ],
                      // ),

                      // 10.heightBox,
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 100,
                      //       child: boldText(text: "Size L", color: fontGrey)
                      //     ),
                      //     normalText(text: "${data['p_quantity_l']} items", color: fontGrey)
                      //   ],
                      // ),

                      // 10.heightBox,
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 100,
                      //       child: boldText(text: "Size XL", color: fontGrey)
                      //     ),
                      //     normalText(text: "${data['p_quantity_xl']} items", color: fontGrey)
                      //   ],
                      // ),

                      // 10.heightBox,
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 100,
                      //       child: boldText(text: "Size XXL", color: fontGrey)
                      //     ),
                      //     normalText(text: "${data['p_quantity_xxl']} items", color: fontGrey)
                      //   ],
                      // ),

                      // 10.heightBox,
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 100,
                      //       child: boldText(text: "Quantity", color: fontGrey)
                      //     ),
                      //     normalText(text: "${data['p_quantity_s']}" + "${data['p_quantity_m']}" + "${data['p_quantity_l']}" + "${data['p_quantity_xl']}" + "${data['p_quantity_xxl']} items", color: fontGrey)
                      //   ],
                      // ),

                    ],
                  ).box.white.padding(const EdgeInsets.all(8.0)).shadowSm.make(),
                  const Divider(),
                  20.heightBox,
                  boldText(text: "Description", color: fontGrey),
                  10.heightBox,
                  normalText(text: "${data['p_desc']}", color: fontGrey),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}