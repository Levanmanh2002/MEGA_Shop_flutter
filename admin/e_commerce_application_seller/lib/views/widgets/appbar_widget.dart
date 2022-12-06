import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'package:e_commerce_application_seller/const/const.dart';
import 'package:e_commerce_application_seller/views/widgets/text_style.dart';

AppBar appbarWidget(title) {
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: fontGrey, size: 16.0),
    actions: [
      Center(
        child: normalText(text: intl.DateFormat('EEEE, MMMM d, ' 'y').format(DateTime.now()), color: purpleColor),
      ),
      10.widthBox,
    ],
  );
}
