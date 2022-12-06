import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application_flutter/consts/consts.dart';
import 'package:e_commerce_application_flutter/consts/list.dart';
import 'package:e_commerce_application_flutter/controller/auth_controller.dart';
import 'package:e_commerce_application_flutter/controller/profile_controller.dart';
import 'package:e_commerce_application_flutter/services/firebase_services.dart';
import 'package:e_commerce_application_flutter/view/auth_screen/login_screen.dart';
import 'package:e_commerce_application_flutter/view/chat_screen/messaging_screen.dart';
import 'package:e_commerce_application_flutter/view/order_screen/order_screen.dart';
import 'package:e_commerce_application_flutter/view/profile_screen/components/details_cart.dart';
import 'package:e_commerce_application_flutter/view/profile_screen/edit_profile_screen.dart';
import 'package:e_commerce_application_flutter/view/wishlist_screen/wishlist_screen.dart';
import 'package:e_commerce_application_flutter/widgets_common/bg_widget.dart';
import 'package:e_commerce_application_flutter/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
          body: StreamBuilder(
        stream: FirebaseService.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshort) {
          if (!snapshort.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else {
            var data = snapshort.data!.docs[0];

            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.edit,
                        color: whiteColor,
                      ),
                    ).onTap(() {
                      controller.nameController.text = data['name'];

                      Get.to(() => EditProfileScreen(data: data));
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        data['imageUrl'] == ''
                            ? Image.asset(imgProfile2, width: 50, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(data['imageUrl'], width: 50, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                        10.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}".text.fontFamily(semibold).white.make(),
                              "${data['email']}".text.white.make(),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: whiteColor,
                            ),
                          ),
                          onPressed: () async {
                            await Get.put(AuthController()).signOutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: logout.text.fontFamily(semibold).white.make(),
                        ),
                      ],
                    ),
                  ),
                  20.heightBox,
                  FutureBuilder(
                      future: FirebaseService.getCounts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: loadingIndicator());
                        } else {
                          var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCart(
                                count: countData[0].toString(),
                                title: "in your cart",
                                width: context.screenWidth / 3.3,
                              ),
                              detailsCart(
                                count: countData[1].toString(),
                                title: "in your wishlist",
                                width: context.screenWidth / 3.3,
                              ),
                              detailsCart(
                                count: countData[2].toString(),
                                title: "your order",
                                width: context.screenWidth / 3.3,
                              ),
                            ],
                          );
                        }
                      }),
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(color: lightGrey);
                    },
                    itemCount: profileButtonsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const OrderScreen());
                              break;
                            case 1:
                              Get.to(() => const WishlistScreen());
                              break;
                            case 2:
                              Get.to(() => const MessagingScreen());
                              break;
                          }
                        },
                        leading: Image.asset(
                          profileButtonIcon[index],
                          width: 22,
                          color: darkFontGrey,
                        ),
                        title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                      );
                    },
                  )
                      .box
                      .white
                      .rounded
                      .margin(const EdgeInsets.all(12))
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .shadowSm
                      .make()
                      .box
                      .color(redColor)
                      .make(),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}
