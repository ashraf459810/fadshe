import 'package:fad_shee/providers/user_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).redirectTo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitChasingDots(color: AppColors.grey.withOpacity(0.4)),
    );
  }
}
