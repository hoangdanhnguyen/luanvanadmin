import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/views/search_screen/search_data_screen.dart';
import 'package:admin_luanvan/views/search_screen/search_screen.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget(title){
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    
      title: boldText(text: title,color: fontGrey,size: 16.0),
      actions: [
        IconButton(onPressed: () {
            //Get.to(()=> const SearchFirebase());
            Get.to(()=> const searchData());
          }, icon: const Icon(Icons.search, color: Colors.black,)),
        Center(
          child: boldText(text: intl.DateFormat('EEE, d MMM, ' 'yyyy').format(DateTime.now()),color: purpleColor)
        ),
      10.widthBox,
    ],
  );
}