import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application_seller/const/const.dart';
import 'package:e_commerce_application_seller/const/firebase_consts.dart';
import 'package:e_commerce_application_seller/controller/auth_controller.dart';
import 'package:e_commerce_application_seller/controller/profile_controller.dart';
import 'package:e_commerce_application_seller/services/store_services.dart';
import 'package:e_commerce_application_seller/views/auth_screen/login_screen.dart';
import 'package:e_commerce_application_seller/views/messages_screen/messages_screen.dart';
import 'package:e_commerce_application_seller/views/profile_screen/edit_profile_screen.dart';
import 'package:e_commerce_application_seller/views/shop_screen/shop_settings_screen.dart';
import 'package:e_commerce_application_seller/views/widgets/loading_indicator.dart';
import 'package:e_commerce_application_seller/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: settings, size: 16.0),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditProfileScreen(username: controller.snapshortData['vendor_name']));
                },
                icon: const Icon(Icons.edit)),
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>().signOutMethod(context);
                  Get.offAll(() => const LoginScreen());
                },
                child: normalText(text: logout)),
          ],
        ),
        body: FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator(circleColor: white));
            } else {
              controller.snapshortData = snapshot.data!.docs[0];
              print(controller.snapshortData);
              return Column(
                children: [
                  ListTile(
                    leading: controller.snapshortData['imageUrl'] == ''
                        ? Image.asset(imgProfile, width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make()
                        : Image.network(controller.snapshortData['imageUrl'], width: 100)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                    title: boldText(text: "${controller.snapshortData['vendor_name']}"),
                    subtitle: normalText(text: "${controller.snapshortData['email']}"),
                  ),
                  const Divider(),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(
                          2,
                          (index) => ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const ShopSettingScreen());
                                      break;
                                    case 1:
                                      Get.to(() => const MessageScreen());
                                      break;
                                  }
                                },
                                leading: Icon(profileButtonsIcons[index], color: white),
                                title: normalText(text: profileButtonTitles[index]),
                              )),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
