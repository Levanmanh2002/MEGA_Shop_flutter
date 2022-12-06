import 'package:e_commerce_application_seller/const/colors.dart';
import 'package:e_commerce_application_seller/const/const.dart';
import 'package:e_commerce_application_seller/views/widgets/text_style.dart';
import 'package:flutter/material.dart';

Widget ourButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: normalText(text: title, size: 16.0),
  );
}
