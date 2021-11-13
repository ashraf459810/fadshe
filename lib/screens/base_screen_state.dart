import 'package:flutter/material.dart';

abstract class BaseScreenState<T extends StatefulWidget> extends State<T> {
  Widget appBar(BuildContext context) => null;
  Widget buildState(BuildContext context) => Container();
  bool resizeToAvoidBottomInset() => false;
  onBuildStart() => null;

  @override
  Widget build(BuildContext context) {
    onBuildStart();
    return Scaffold(
      appBar: appBar(context),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
      body: SafeArea(
        child: buildState(context),
      ),
    );
  }
}
