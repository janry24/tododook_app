import 'package:flutter/material.dart';
import 'package:tododook_app/defines/color_defines.dart';

class CustomSearchBar extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomSearchBar({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          // color: Color(0xFFFFFFFF),
          border: Border.all(
            color: ColorDefines.bgGrey,
            width: 2
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: ColorDefines.textGrey,
                  ),
                  border: InputBorder.none,
                ),
                keyboardType: keyboardType,
                obscureText: obscureText,
                enableSuggestions: !obscureText,
                autocorrect: !obscureText,
                validator: validator
              ),
            ),
            IconButton(
                onPressed: (){
                  print('click search');
                },
                icon: Icon(icon, color: ColorDefines.iconDark),
              ),
          ],
        ),
      ),
    );
  }
}
