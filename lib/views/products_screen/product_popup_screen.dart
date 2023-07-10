import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/controllers/product_controller.dart';
import 'package:admin_luanvan/services/store_services.dart';
import 'package:admin_luanvan/views/widget/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';

class ProductPopupCard extends StatelessWidget {
  final dynamic data;
  const ProductPopupCard({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black)
        ),
      
      ),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image.network(
                    //   data['p_imgs'][2],
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    // )
                  ]
                ),
              ),
            );
          }
        }
      ),
    );
  }
}