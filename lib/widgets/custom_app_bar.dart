import 'package:fad_shee/theme/AppColors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final BuildContext context;
  final String titleText;
  final String subtitleText;
  final bool centerTitle;
  final Widget leadingIcon;
  final List<Widget> actions;
  final bool showBackButton;

  CustomAppBar({
    @required this.context,
    @required this.titleText,
    this.subtitleText,
    this.centerTitle = true,
    this.leadingIcon = const Icon(Icons.arrow_back),
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget get leading => showBackButton
      ? IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: leadingIcon,
        )
      : Container();

  @override
  Widget get title => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleText.toUpperCase(), style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.white)),
          if (subtitleText != null)
            Text(subtitleText, style: Theme.of(context).textTheme.button.copyWith(color: Colors.grey[500]))
        ],
      );

  @override
  Color get backgroundColor => AppColors.red;

  @override
  double get elevation => 0;

  @override
  IconThemeData get iconTheme => IconThemeData(color: Colors.white);

  @override
  IconThemeData get actionsIconTheme => IconThemeData(color: Colors.white);

  @override
  Brightness get brightness => Brightness.dark;
}
