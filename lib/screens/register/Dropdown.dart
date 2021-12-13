import 'package:fad_shee/theme/AppColors.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final String chosenvalue;
  final String hint;
  final List<dynamic> list;
  final Function onchanged;
  final Function getindex;
  DropDown(
      {this.chosenvalue, this.hint, this.list, this.onchanged, this.getindex});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String chosenvalue;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<dynamic>(
      isExpanded: true,
      underline: SizedBox(),
      hint: chosenvalue == null
          ? Center(
              child: Text(widget.hint, style: TextStyle(color: AppColors.blue)))
          : Center(child: Text(chosenvalue)),
      items: widget.list.map((dynamic value) {
        return DropdownMenuItem<dynamic>(
            value: value,
            child: value is String
                ? Center(child: new Text(value))
                : Center(child: new Text(value.title)));
      }).toList(),
      onChanged: (value) {
        setState(() {
          widget.onchanged(value);
          value is String ? chosenvalue = value : chosenvalue = value.title;
        });
      },
    );
  }
}
