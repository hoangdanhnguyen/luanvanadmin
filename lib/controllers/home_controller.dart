import 'package:admin_luanvan/const/const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

var navIndex = 0.obs;
  var username = '';

  @override
  void onInit() {
    super.onInit();
    getUsername();
  }

  
  getUsername() async {
    var n = await firestore
    .collection(vendorsCollection)
    .where('id', isEqualTo: currentUser!.uid)
    .get()
    .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['vendor_name'];
      }
    });

    username = n;
  }
}