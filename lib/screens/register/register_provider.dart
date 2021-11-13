import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';

class RegisterProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'name': null, 'email': null, 'phone': null, 'password': null};
  List<FocusNode> focusNodes = [FocusNode(), FocusNode(), FocusNode(), FocusNode()];

  get keyboardActionsConfig => KeyboardActionsConfig(
        actions: [
          ...focusNodes.map((node) => KeyboardActionsItem(focusNode: node)).toList(),
        ],
      );

  bool validateAndSaveFromData() {
    if (!formKey.currentState.validate()) return false;
    formKey.currentState.save();
    return true;
  }
}
