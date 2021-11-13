import 'package:fad_shee/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final bool showBorder;
  final Widget prefixIcon;
  final bool isRequired;
  final TextInputType keyboardType;
  final String hint;
  final TextAlign textAlign;
  final String backingFieldName;
  final Map backingFieldMap;
  final Color borderColor;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final FocusNode nextFocusNode;
  final RegExp regex;
  final List<TextInputFormatter> textInputFormatters;
  final TextStyle textStyle;
  final bool isLTR;
  final EdgeInsets padding;
  final List<String> errors;
  final String label;
  final String text;
  final bool obscureText;
  final bool autoFocus;
  final Function(String) onFieldSubmitted;
  final Function(String) onChanged;
  final TextEditingController controller;
  final int lines;

  CustomTextField(
      {this.showBorder = false,
      this.prefixIcon,
      this.isRequired = false,
      this.keyboardType = TextInputType.text,
      this.hint = '',
      this.textAlign = TextAlign.start,
      this.borderColor = AppColors.midGrey,
      this.focusNode,
      this.textInputAction,
      this.nextFocusNode,
      this.regex,
      this.textStyle,
      this.isLTR = false,
      this.textInputFormatters,
      this.padding,
      this.errors,
      this.label,
      this.text,
      this.obscureText = false,
      this.autoFocus = false,
      this.onFieldSubmitted,
      this.onChanged,
      this.backingFieldMap,
      this.backingFieldName,
      this.controller,
      this.lines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: text,
      controller: controller,
      obscureText: obscureText,
      validator: (value) {
        if (isRequired && value.isEmpty)
          return 'This field is required';
        else if (regex != null && !regex.hasMatch(value.replaceAll(' ', ''))) return 'msg_invalid_value';
        return null;
      },
      onSaved: (value) {
        backingFieldMap[backingFieldName] = value;
      },
      inputFormatters: textInputFormatters != null ? textInputFormatters : [],
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: (value) {
        if (onFieldSubmitted != null) onFieldSubmitted(value);
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
      onChanged: (value) {
        if (onChanged != null) onChanged(value);
      },
      textAlign: textAlign,
      maxLines: lines,
      textDirection: isLTR ? TextDirection.ltr : null,
      keyboardType: keyboardType,
      autofocus: autoFocus,
      style: textStyle != null ? textStyle : Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black),
      decoration: InputDecoration(
          border: showBorder
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor, width: 1), borderRadius: BorderRadius.all(Radius.circular(5)))
              : OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: showBorder
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor, width: 1), borderRadius: BorderRadius.all(Radius.circular(5)))
              : OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: showBorder
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor, width: 1), borderRadius: BorderRadius.all(Radius.circular(5)))
              : OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: showBorder
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor, width: 1), borderRadius: BorderRadius.all(Radius.circular(5)))
              : OutlineInputBorder(borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white,
          contentPadding: padding == null ? EdgeInsets.symmetric(horizontal: 8) : padding,
          hintText: hint,
          labelText: label,
          errorText: errors != null && errors.length > 0 ? errors[0] : null,
          prefixIcon: prefixIcon,
          hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.midGrey),
          labelStyle: Theme.of(context).textTheme.headline5.copyWith(color: AppColors.grey),
          errorStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 11, color: AppColors.errorColor)),
    );
  }
}
