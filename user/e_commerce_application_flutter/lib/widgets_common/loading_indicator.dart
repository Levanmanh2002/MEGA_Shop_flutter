import 'package:e_commerce_application_flutter/consts/colors.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
