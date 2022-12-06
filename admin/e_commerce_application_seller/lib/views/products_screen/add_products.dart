import 'package:e_commerce_application_seller/const/const.dart';
import 'package:e_commerce_application_seller/controller/products_controller.dart';
import 'package:e_commerce_application_seller/views/products_screen/components/product_dropdown.dart';
import 'package:e_commerce_application_seller/views/products_screen/components/product_images.dart';
import 'package:e_commerce_application_seller/views/widgets/custom_textfield.dart';
import 'package:e_commerce_application_seller/views/widgets/loading_indicator.dart';
import 'package:e_commerce_application_seller/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();

    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: boldText(text: "Add Product", color: fontGrey, size: 16.0),
          actions: [
            controller.isLoading.value
                ? Center(child: loadingIndicator(circleColor: white))
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.uploadImages();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(text: save, color: white))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextfield(hint: "eg. Name", label: "Product name", controller: controller.pnameController),
                10.heightBox,
                customTextfield(
                    hint: "eg. Nice products",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pdescController),
                10.heightBox,
                customTextfield(hint: "eg. \$1000", label: "Price", controller: controller.ppriceController),
                10.heightBox,
                customTextfield(hint: "eg. 10", label: "Quantity", controller: controller.pquantityController),
                10.heightBox,
                productDropdown("Category", controller.categoryList, controller.categoryvalue, controller),
                10.heightBox,
                productDropdown("Subcategory", controller.subcategoryList, controller.categoryvalue, controller),
                10.heightBox,
                const Divider(color: white),
                normalText(text: "Choose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => controller.pImagesList[index] != null
                          ? Image.file(controller.pImagesList[index], width: 100).onTap(() {
                              controller.pickImages(index, context);
                            })
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImages(index, context);
                            }),
                    ),
                  ),
                ),
                5.heightBox,
                normalText(text: "First images will be your display images", color: lightGrey),
                const Divider(color: white),
                10.heightBox,
                normalText(text: "Choose product colors"),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      9,
                      (index) => Stack(
                        alignment: Alignment.center,
                        children: [
                          VxBox().color(Vx.randomPrimaryColor).roundedFull.size(65, 65).make().onTap(() {
                            controller.selectedColorIndex.value = index;
                          }),
                          controller.selectedColorIndex.value == index
                              ? const Icon(Icons.done, color: white)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
