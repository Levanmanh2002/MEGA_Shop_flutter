import 'package:e_commerce_application_flutter/consts/consts.dart';
import 'package:e_commerce_application_flutter/consts/list.dart';
import 'package:e_commerce_application_flutter/controller/auth_controller.dart';
import 'package:e_commerce_application_flutter/view/auth_screen/signup_screen.dart';
import 'package:e_commerce_application_flutter/view/home_screen/home_page.dart';
import 'package:e_commerce_application_flutter/widgets_common/applogo_widget.dart';
import 'package:e_commerce_application_flutter/widgets_common/bg_widget.dart';
import 'package:e_commerce_application_flutter/widgets_common/custom_textfield.dart';
import 'package:e_commerce_application_flutter/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Login to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        title: email, hint: emailHint, isPass: false, controller: controller.emailController),
                    customTextField(
                        title: password, hint: passwordHint, isPass: true, controller: controller.passwordController),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: forgetPass.text.make(),
                      ),
                    ),
                    5.heightBox,
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            title: login,
                            color: redColor,
                            textColor: whiteColor,
                            onPress: () async {
                              controller.isLoading(true);
                              await controller.loginMethod(context: context).then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const HomePage());
                                } else {
                                  controller.isLoading(false);
                                }
                              });
                            },
                          ).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButton(
                      title: signup,
                      color: lightGrey,
                      textColor: darkFontGrey,
                      onPress: () {
                        Get.to(() => const SignUpScreen());
                      },
                    ).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    loginWidget.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(
                              socialIconList[index],
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
