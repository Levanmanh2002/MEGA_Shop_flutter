import 'package:e_commerce_application_seller/const/const.dart';
import 'package:e_commerce_application_seller/controller/profile_controller.dart';
import 'package:e_commerce_application_seller/views/widgets/custom_textfield.dart';
import 'package:e_commerce_application_seller/views/widgets/loading_indicator.dart';
import 'package:e_commerce_application_seller/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopSettingScreen extends StatelessWidget {
  const ShopSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopname: controller.shopNameController.text,
                        shopaddress: controller.shopAddressController.text,
                        shopmobile: controller.shopMobileController.text,
                        shopwebsite: controller.shopWebsiteController.text,
                        shopdesc: controller.shopDescController.text,
                      );
                      VxToast.show(context, msg: "Shop updated");
                    },
                    child: normalText(text: save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextfield(label: shopName, hint: nameHint, controller: controller.shopNameController),
              10.heightBox,
              customTextfield(label: address, hint: shopAddressHint, controller: controller.shopAddressController),
              10.heightBox,
              customTextfield(label: mobile, hint: shopMobileHint, controller: controller.shopMobileController),
              10.heightBox,
              customTextfield(label: website, hint: shopWebsiteHint, controller: controller.shopWebsiteController),
              10.heightBox,
              customTextfield(
                  isDesc: true, label: description, hint: shopDescHint, controller: controller.shopDescController),
            ],
          ),
        ),
      ),
    );
  }
}
