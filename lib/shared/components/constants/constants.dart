import 'package:flutter/material.dart';
import 'package:todo_appppp/modules/login_screen/login_screen.dart';
import 'package:todo_appppp/shared/components/components/components.dart';
import 'package:todo_appppp/shared/network/local/cache_helper.dart';


void signOut(BuildContext context, String key) {
  CacheHelper.removeData(key: key).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        const AppLoginScreen(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //size each chuck 800
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}