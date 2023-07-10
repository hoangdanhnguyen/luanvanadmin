import 'package:admin_luanvan/controllers/order_controller.dart';
import 'package:admin_luanvan/services/store_services.dart';
import 'package:admin_luanvan/views/orders_screen/order_details.dart';
import 'package:admin_luanvan/views/widget/appbar_widget.dart';
import 'package:admin_luanvan/views/widget/loading_indicator.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';
import 'package:admin_luanvan/const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  var controller = Get.put(OrderController());
  
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
        stream: StoreServices.getOrders(currentUser!.uid),
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
                  // children: StreamBuilder(stream: StoreServices.getOrders(currentUser!.uid),builder:(BuildContext context,snapshot){

                  // } ,)
                  // ),
                 
                children: List.generate(data.length, (index) {

                  var time = data[index]['order_date'].toDate();
                  return ListTile(
                      onTap: () {
                        Get.to(() => OrderDetails(data: data[index]));
                      },
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      
                      title: boldText(text: "${data[index]['order_code']}", color: Colors.black),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_month, color: fontGrey),
                              10.widthBox,
                              normalText(text: intl.DateFormat().add_yMd().format(time), color: fontGrey),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.payment, color: fontGrey),
                              10.widthBox,
                              normalText(text: unpaid, color: red),
                            ],
                          ),
                        ],
                      ),
                      trailing: boldText(text: "\$ ${data[index]['total_amount']}", color: purpleColor, size: 16.0),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                } 
                  ),
                ),
              ),
            );
          }
        },
      ),
      
    );
  }
}