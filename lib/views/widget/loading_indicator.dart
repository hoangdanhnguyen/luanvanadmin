import 'package:admin_luanvan/const/const.dart';

Widget loadingIndicator({cicleColor = purpleColor}) {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(cicleColor),
    ),
  );
}