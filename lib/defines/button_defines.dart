import 'package:flutter/material.dart';
import 'color_defines.dart';

class ButtonDefines {
  static ButtonStyle kakaoLoginElBtn = ElevatedButton.styleFrom(
    backgroundColor: ColorDefines.kakaoLoginBtnColor,
    minimumSize: const Size.fromHeight(50),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
    ),
  );
}