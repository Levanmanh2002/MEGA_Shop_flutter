import 'package:e_commerce_application_seller/const/colors.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator({circleColor = purpleColor}) {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(circleColor),
  );
}
