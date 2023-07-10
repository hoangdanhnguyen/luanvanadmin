import '/const/const.dart';
import '/controllers/home_controller.dart';
import '/views/home_screen/home_screen.dart';
import '/views/orders_screen/orders_screen.dart';
import '/views/products_screen/products_screen.dart';
import '/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navScreens = [
      const HomeScreen(), const ProductScreen(), const OrderScreen(), const ProfileScreen()
    ];

    var bottomNarbar = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),label: dashboard
        ),
      BottomNavigationBarItem(
        icon: Image.asset(icProducts,
        color: darkGrey,
        width: 24),
        label: products,
        ),
      BottomNavigationBarItem(
        icon: Image.asset(icOrders,
        width: 24,
        color: darkGrey),
        label: orders
        ),
      BottomNavigationBarItem(
        icon: Image.asset(icGeneralSettings,
        width: 24,
        color: darkGrey), label: settings
        ),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(() => BottomNavigationBar(
          onTap: (index){
            controller.navIndex.value = index;
          },
          backgroundColor: white,
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          items: bottomNarbar,
        ),
      ),
      body: Obx(() => Column(
          children: [
            Expanded(
              child: navScreens.elementAt(controller.navIndex.value),
              ),
          ],
        ),
      ),
    );
  }
}