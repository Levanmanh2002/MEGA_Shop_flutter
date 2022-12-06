import 'package:e_commerce_application_seller/const/const.dart';
import 'package:e_commerce_application_seller/controller/home_controller.dart';
import 'package:e_commerce_application_seller/views/home_screen/home_screen.dart';
import 'package:e_commerce_application_seller/views/order_screen/order_screen.dart';
import 'package:e_commerce_application_seller/views/products_screen/products_screen.dart';
import 'package:e_commerce_application_seller/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [const HomeScreen(), const ProductsScreen(), const OrderScreen(), const ProfileScreen()];

    var bottomNavbar = [
      BottomNavigationBarItem(icon: Image.asset(icHome, color: darkGrey, width: 24), label: dashboard),
      BottomNavigationBarItem(icon: Image.asset(icProducts, color: darkGrey, width: 24), label: products),
      BottomNavigationBarItem(icon: Image.asset(icOrders, color: darkGrey, width: 24), label: order),
      BottomNavigationBarItem(icon: Image.asset(icGeneralSettings, color: darkGrey, width: 24), label: settings),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          items: bottomNavbar,
        ),
      ),
      body: Obx(
        () => Column(
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
