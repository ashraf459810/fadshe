import 'dart:convert';
import 'dart:developer';

import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/user.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/base_repository.dart';
import 'package:fad_shee/repositories/invoice_repository.dart';
import 'package:fad_shee/repositories/order_repository.dart';
import 'package:fad_shee/repositories/wish_list_repository.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository extends BaseRepository {
  String _token;

  String get token => _token;
  User _user;

  User get user => _user;
  bool isFirstVisit;

  bool get isLoggedIn => user != null;

  Future loadUserInfo() async {
    String firstVisit =
        await getIt<FlutterSecureStorage>().read(key: 'first_visit');
    isFirstVisit = firstVisit == null || firstVisit != 'false';
    _token = await getIt<FlutterSecureStorage>().read(key: 'token');
    String userData = await getIt<FlutterSecureStorage>().read(key: 'user');
    if (userData != null) _user = User.fromJson(json.decode(userData));
  }

  Future setNotFirstVisit() async => await getIt<FlutterSecureStorage>()
      .write(key: 'first_visit', value: 'false');

  Future setToken(accessToken) async {
    _token = accessToken;
    await getIt<FlutterSecureStorage>().write(key: 'token', value: accessToken);
  }

  Future<Result> register(Map<String, String> formData) async {
    print(formData);
    log(formData['cities_id']);
    Result result = await getIt.get<ApiService>().authentication.register(
          formData['name'],
          formData['email'],
          formData['phone'],
          formData['password'],
          formData['cities_id'],
        );
    if (result.isSuccessful) {
      String accessToken = result.result as String;
      await setToken(accessToken);
      return await fetchUserData();
    } else
      return result;
  }

  Future<Result> login(Map<String, String> formData) async {
    Result result = await getIt
        .get<ApiService>()
        .authentication
        .login(formData['email'], formData['password']);
    if (result.isSuccessful) {
      String accessToken = result.result as String;
      await setToken(accessToken);
      return await fetchUserData();
    } else
      return Result(message: "Wrong Email Or Passwrod", isSuccessful: false);
  }

  Future<Result> getCities() async {
    log("here from repo");
    var result = await getIt.get<ApiService>().cities.getCities();

    if (result.isSuccessful) {
      return result;
    } else
      return Result(message: "Wrong Email Or Passwrod", isSuccessful: false);
  }

  Future<Result> loginwithapple(String email) async {
    Result result =
        await getIt.get<ApiService>().authentication.signwithapple(email);
    if (result.isSuccessful) {
      String accessToken = result.result as String;
      await setToken(accessToken);
      return await fetchUserData();
    } else
      return result;
  }

  Future<Result> loginWithFacebook() async {
    try {
      AccessToken facebookAuthResponse = await FacebookAuth.instance.login(
        // loginBehavior: LoginBehavior.n,
        permissions: ['email', 'public_profile'],
      );
      String facebookToken = facebookAuthResponse.token;
      print(facebookToken);
      Result result = await getIt
          .get<ApiService>()
          .authentication
          .loginWithFacebook(facebookToken);
      if (result.isSuccessful) {
        String accessToken = result.result as String;
        await setToken(accessToken);
        return await fetchUserData();
      } else
        return result;
    } on FacebookAuthException catch (e) {
      String errorMessage = 'Error: ';
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          errorMessage += "You have a previous login operation in progress";
          break;
        case FacebookAuthErrorCode.CANCELLED:
          errorMessage += "login cancelled";
          break;
        case FacebookAuthErrorCode.FAILED:
          errorMessage += "login failed";
          break;
      }
      return Result(isSuccessful: false, message: errorMessage);
    }
  }

  Future<Result> fetchUserData() async {
    Result result =
        await getIt.get<ApiService>().authentication.fetchUserData();
    if (result.isSuccessful) {
      _user = (result.result as User);
      String userData = json.encode(user);
      await getIt<FlutterSecureStorage>().write(key: 'user', value: userData);
      return result;
    } else
      return result;
  }

  Future<Result> updateUserData(User user) async {
    Result result = await getIt.get<ApiService>().user.updateUserData(user);
    if (result.isSuccessful) {
      _user = (result.result as User);
      String userData = json.encode(user);
      await getIt<FlutterSecureStorage>().write(key: 'user', value: userData);
      return result;
    } else
      return result;
  }

  Future logout() async {
    await getIt<FlutterSecureStorage>().delete(key: 'token');
    await getIt<FlutterSecureStorage>().delete(key: 'user');
    await getIt<WishListRepository>().clearData();
    await getIt<OrderRepository>().clearData();
    await getIt<InvoiceRepository>().clearData();
    this.clearData();
  }

  @override
  clearData() {
    _token = null;
    _user = null;
  }
}
