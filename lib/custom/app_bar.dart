import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tododook_app/defines/color_defines.dart';
import 'package:tododook_app/defines/font_defines.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String headlineText;

  const CustomAppBar({
    Key? key,
    required this.headlineText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(headlineText, style: FontDefines.headlineTitle),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              ColorDefines.bgSkyBlue,
              ColorDefines.bgWhite,
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: (){},
            icon: const Icon(
              CupertinoIcons.ellipsis,
              color: ColorDefines.iconDark,
            ),
          )
        )
      ],
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       // 삭제 버튼 클릭시
      //       showDeleteDialog(context, memoService);
      //     },
      //     icon: const Icon(Icons.delete),
      //   )
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
