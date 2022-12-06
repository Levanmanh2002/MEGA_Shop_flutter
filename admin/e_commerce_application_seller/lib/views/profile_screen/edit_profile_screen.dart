import 'dart:io';

import 'package:e_commerce_application_seller/const/const.dart';
import 'package:e_commerce_application_seller/controller/profile_controller.dart';
import 'package:e_commerce_application_seller/views/widgets/custom_textfield.dart';
import 'package:e_commerce_application_seller/views/widgets/loading_indicator.dart';
import 'package:e_commerce_application_seller/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, required this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: settings, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);

                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink = controller.snapshortData['imageUrl'];
                      }

                      if (controller.snapshortData['password'] == controller.oldPassController.text) {
                        await controller.changeAuthPassword(
                          email: controller.snapshortData['email'],
                          password: controller.oldPassController.text,
                          newpassword: controller.newPassController.text,
                        );
                        await controller.updateProfileDocument(
                          imgUrl: controller.profileImageLink,
                          name: controller.nameController.text,
                          password: controller.newPassController.text,
                        );
                        VxToast.show(context, msg: "Updated");
                      } else if (controller.oldPassController.text.isEmptyOrNull &&
                          controller.newPassController.text.isEmptyOrNull) {
                        await controller.updateProfileDocument(
                          imgUrl: controller.profileImageLink,
                          name: controller.nameController.text,
                          password: controller.snapshortData['password'],
                        );
                        VxToast.show(context, msg: "Updated");
                      } else {
                        VxToast.show(context, msg: "Some error occured");
                        controller.isLoading(false);
                      }
                    },
                    child: normalText(text: save),
                  ),
          ],
        ),
        body: Column(
          children: [
            controller.snapshortData['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(imgProduct, width: 100, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                : controller.snapshortData['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        controller.snapshortData['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: white),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: changeImage, color: fontGrey)),
            10.heightBox,
            const Divider(color: white),
            customTextfield(label: name, hint: "eg. anhbao", controller: controller.nameController),
            30.heightBox,
            Align(alignment: Alignment.centerLeft, child: boldText(text: "Change your password")),
            10.heightBox,
            customTextfield(label: password, hint: passwordHint, controller: controller.oldPassController),
            10.heightBox,
            customTextfield(label: confirmPass, hint: passwordHint, controller: controller.newPassController),
          ],
        ),
      ),
    );
  }
}
