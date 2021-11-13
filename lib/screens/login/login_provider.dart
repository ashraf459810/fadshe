import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'email': null, 'password': null};
  List<FocusNode> focusNodes = [FocusNode(), FocusNode()];

  bool validateAndSaveFromData() {
    if (!formKey.currentState.validate()) return false;
    formKey.currentState.save();
    return true;
  }
}
