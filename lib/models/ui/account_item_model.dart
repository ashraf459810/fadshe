import 'package:flutter/material.dart';

class AccountItemModel {
  final String icon;
  final String title;
  final String subtitle;
  final String onClickNavigateTo;
  final Function onClick;
  final Color iconColor;
  final bool showArrow;

  AccountItemModel({
    this.icon,
    this.title,
    this.subtitle,
    this.onClickNavigateTo,
    this.iconColor,
    this.onClick,
    this.showArrow = true,
  });
}
