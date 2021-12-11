import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/user.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/user_repository.dart';
import 'package:fad_shee/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserProvider with ChangeNotifier {
  UserRepository userRepository = getIt<UserRepository>();
  bool loading = false;
  StreamController<String> message = StreamController.broadcast();

  Map<String, dynamic> userMap;
  final editProfileFormKey = GlobalKey<FormState>();

  bool isFirstVisit;

  User get user => userRepository.user;

  bool get isLoggedIn => userRepository.isLoggedIn;

  Future redirectTo() async {
    await userRepository.loadUserInfo();
    userMap = userRepository.user?.toMap();
    navService.pushNamedAndRemoveUntil(MainScreen.routeName);
  }

  Future setNotFirstVisit() async => userRepository.setNotFirstVisit();

  Future register(Map<String, String> formData) async {
    loading = true;
    notifyListeners();
    Result result = await userRepository.register(formData);
    if (result.isSuccessful) {
      userMap = userRepository.user?.toMap();
      navService.pushNamedAndRemoveUntil('/');
    } else
      message.sink.add(result.message);
    loading = false;
    notifyListeners();
  }

  Future login(Map<String, String> formData) async {
    loading = true;
    notifyListeners();
    Result result = await userRepository.login(formData);
    if (result.isSuccessful) {
      userMap = userRepository.user?.toMap();
      navService.pushNamedAndRemoveUntil('/');
    } else
      message.sink.add(result.message);
    loading = false;
    notifyListeners();
  }

  Future loginWithFacebook() async {
    loading = true;
    notifyListeners();
    Result result = await userRepository.loginWithFacebook();
    if (result.isSuccessful) {
      userMap = userRepository.user?.toMap();
      navService.pushNamedAndRemoveUntil('/');
    } else
      message.sink.add(result.message);
    loading = false;
    notifyListeners();
  }

  //// here theapple sign in code
  Future loginWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
        clientId: 'com.fadshee.fadshe',
        redirectUri: Uri.parse(
          'https://fadshee.com/api/apple/login/controller/login/action',
        ),
      ),
      // TODO: Remove these if you have no need for them
      nonce: 'example-nonce',
      state: 'example-state',
    );

    print(credential.authorizationCode);
    print(credential.state);
    if (credential.email != null) {
      Result result = await userRepository.loginwithapple(credential.email);

      if (result.isSuccessful == true) {
        navService.pushNamedAndRemoveUntil('/');
      }
    }

    // final signInWithAppleEndpoint = Uri(
    //   scheme: 'https',
    //   host: 'flutter-sign-in-with-apple-example.glitch.me',
    //   path: '/sign_in_with_apple',
    //   queryParameters: <String, String>{
    //     'code': credential.authorizationCode,
    //     'firstName': credential.givenName,
    //     'lastName': credential.familyName,
    //     'useBundleId': Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
    //     if (credential.state != null) 'state': credential.state,
    //   },
    // );

    // final session = await http.Client().post(
    //   signInWithAppleEndpoint,
    // );

    // If we got this far, a session based on the Apple ID credential has been created in your system,
    // and you can now set this as the app's session
    // print(session);

    // loading = true;
    // notifyListeners();
    // Result result = await userRepository.loginWithFacebook();
    // if (result.isSuccessful) {
    //   userMap = userRepository.user?.toMap();
    //   navService.pushNamedAndRemoveUntil('/');
    // } else
    //   message.sink.add(result.message);
    // loading = false;
    // notifyListeners();
  }

  Future logout() async {
    await userRepository.logout();
    notifyListeners();
  }

  Future updateUserInfo() async {
    if (editProfileFormKey.currentState.validate()) {
      editProfileFormKey.currentState.save();
      loading = true;
      notifyListeners();
      Result result =
          await userRepository.updateUserData(User.fromJson(userMap));
      if (result.isSuccessful) {
        message.sink.add('user_info_updated_successfully'.tr());
        navService.pop();
      } else {
        message.sink.add('Error occurred :(');
      }
      userMap = userRepository.user.toMap();
      loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    if (!message.isClosed) message.close();
    super.dispose();
  }
}
