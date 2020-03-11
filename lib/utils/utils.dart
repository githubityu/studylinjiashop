import 'package:flutter/material.dart';

String getSafeData(String data) {
  return data ?? "";
}

Widget hideKeyword(Widget child, BuildContext context) {
  return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: child,
      onTap: () {
        FocusScope.of(context).unfocus();
      });
}
