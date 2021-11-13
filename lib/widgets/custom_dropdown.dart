import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final double width;
  final String hint;
  final List<Option> options;
  final Option selectedOption;
  final Function onOptionSelected;
  final bool showBorder;
  final AlignmentDirectional textAlign;

  CustomDropdown(
      {this.width,
      this.hint = '',
      this.options,
      this.selectedOption,
      @required this.onOptionSelected,
      this.textAlign = AlignmentDirectional.center,
      this.showBorder = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: showBorder ? AppShapes.roundedRectDecoration(borderColor: AppColors.grey.withOpacity(0.2)) : null,
      child: DropdownButtonHideUnderline(
        // to hide dropdown button underline
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[300]),
          selectedItemBuilder: (ctx) => options
              .map<Widget>((option) => Align(
                    alignment: textAlign,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        option.optionName,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black),
                      ),
                    ),
                  ))
              .toList(),
          hint: Align(
            alignment: textAlign,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                hint,
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey[400]),
              ),
            ),
          ),
          items: options
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Align(
                        alignment: textAlign,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(option.optionName,
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black)),
                        )),
                  ))
              .toList(),
          onChanged: (option) {
            onOptionSelected(option);
          },
          value: selectedOption,
        ),
      ),
    );
  }
}

abstract class Option {
  int get optionId;

  String get optionName;
}
