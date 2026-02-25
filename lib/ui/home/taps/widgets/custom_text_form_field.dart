import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  Color colorBorderSide;
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  OnValidator? validator;
  TextEditingController? controller;
  TextInputType? keyboardType;
  bool obscureText;
  int maxLines;

  CustomTextFormField({
    super.key,
    this.colorBorderSide = AppColors.greyColor,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
  });

  String? obscuringCharacter;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: builtDecorationBorder(
            colorBorderSide: colorBorderSide,
          ),
          focusedBorder: builtDecorationBorder(
            colorBorderSide: colorBorderSide,
          ),
          errorBorder: builtDecorationBorder(
            colorBorderSide: AppColors.redColor,
          ),
          focusedErrorBorder: builtDecorationBorder(
            colorBorderSide: AppColors.redColor,
          ),
          hintText: hintText,
          hintStyle: hintStyle ?? AppStyles.medium16Grey,
          labelText: labelText,
          labelStyle: labelStyle ?? AppStyles.medium16Grey,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        obscuringCharacter: '*',
      ),
    );
  }

  OutlineInputBorder builtDecorationBorder({required colorBorderSide}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colorBorderSide, width: 1),
    );
  }
}
