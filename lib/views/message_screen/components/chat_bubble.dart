import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;

// Widget chatBunnle(DocumentSnapshot data){
//   var t =data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
//   var time = intl.DateFormat("h:mma").format(t);
//   return Directionality(
//     textDirection: TextDirection.rtl,
//     child: Container(
//       padding: const EdgeInsets.all(12.0),
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: const BoxDecoration(
//         color: Vx.blue500,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//           bottomLeft: Radius.circular(20),
//         )
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           "${data['msg']}".text.white.size(16).make(),
//         10.heightBox,
//         '${time}'.text.color(white.withOpacity(0.5)).make()
//         ],
//       ),
//     ),
//   );
// }

Widget chatBunnle(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: data['uid'] == currentUser!.uid ? red : darkGrey,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        "${data['msg']}".text.white.size(16).make(),
        10.heightBox,
        '${time}'.text.color(white.withOpacity(0.5)).make()
      ]),
    ),
  );
}
