import 'package:flutter/material.dart';
import 'package:tododook_app/defines/color_defines.dart';

class CustomSearchBar extends StatelessWidget {
  // final IconData icon;
  // final String labelText;
  // final TextInputType keyboardType;
  // final bool obscureText;
  // final TextEditingController? controller;
  // final String? Function(String?)? validator;

  const CustomSearchBar({
    Key? key,
    // required this.icon,
    // required this.labelText,
    // required this.keyboardType,
    // this.obscureText = false,
    // this.controller,
    // this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      trailing: [
        IconButton(
          onPressed: (){},
          icon: const Icon(Icons.search),
        ),
      ],
      backgroundColor: const MaterialStatePropertyAll(ColorDefines.bgWhite),
      elevation: const MaterialStatePropertyAll(3),
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 100),
      shape: MaterialStateProperty.all(ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      )),
    );
  }
}
