import 'package:flutter/material.dart';

import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

const defaultColor = Colors.blue;
String? TOKEN = 'iWTKmSQ0qWmI9Qe24jWR4iCvBz76lKrB8nu9BEGd78L0UV9pWarOvK0rT1WleY8VDNnARX';

void signOut(context) => CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
