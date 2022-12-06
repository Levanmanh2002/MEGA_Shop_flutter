// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:e_commerce_application_flutter/consts/consts.dart';
import 'package:e_commerce_application_flutter/controller/profile_controller.dart';
import 'package:e_commerce_application_flutter/view/profile_screen/profile_screen.dart';
import 'package:e_commerce_application_flutter/widgets_common/bg_widget.dart';
import 'package:e_commerce_application_flutter/widgets_common/custom_textfield.dart';
import 'package:e_commerce_application_flutter/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              const Divider(),
              20.heightBox,
              customTextField(controller: controller.nameController, hint: nameHint, title: name, isPass: false),
              10.heightBox,
              customTextField(
                  controller: controller.oldPassController, hint: passwordHint, title: oldpass, isPass: true),
              10.heightBox,
              customTextField(
                  controller: controller.newPassController, hint: passwordHint, title: newpass, isPass: true),
              20.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.isLoading(true);

                          //if images is not seleted
                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }

                          //if old password matchas data base
                          if (data['password'] == controller.oldPassController.text) {
                            await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldPassController.text,
                              newpassword: controller.newPassController.text,
                            );
                            await controller.updateProfileDocument(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newPassController.text,
                            );
                            VxToast.show(context, msg: updated);
                            Get.to(() => const ProfileScreen());
                          } else {
                            VxToast.show(context, msg: wrongoldpass);
                            controller.isLoading(false);
                          }
                        },
                        textColor: whiteColor,
                        title: "Save",
                      ),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    );
  }
}
