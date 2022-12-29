import 'package:flutter/material.dart';
import 'package:sipapparong_mobile/WIdget/widget.dart';

TextFormField buildTextFormField({
  String? hintText,
  String? labelText,
  IconData? icon,
  bool? obscureText,
  TextEditingController? controller,
  TextInputType? textInputType,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText ?? false,
    keyboardType: textInputType,
    validator: validator,
    style: const TextStyle(
      color: Colors.black,
      fontFamily: 'OpenSans',
    ),
    decoration: buildInputDecoration(hintText!, icon!),
  );
}
