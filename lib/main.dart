import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/navigation/navigation_service.dart';
import 'package:fad_shee/navigation/routes_manager.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/providers/provider_manager.dart';
import 'package:fad_shee/repositories/banner_repository.dart';
import 'package:fad_shee/repositories/brand_repository.dart';
import 'package:fad_shee/repositories/cart_repository.dart';
import 'package:fad_shee/repositories/category_repository.dart';
import 'package:fad_shee/repositories/currency_repository.dart';
import 'package:fad_shee/repositories/home_slides_repository.dart';
import 'package:fad_shee/repositories/invoice_repository.dart';
import 'package:fad_shee/repositories/order_repository.dart';
import 'package:fad_shee/repositories/product_repository.dart';
import 'package:fad_shee/repositories/user_repository.dart';
import 'package:fad_shee/repositories/wish_list_repository.dart';
import 'package:fad_shee/screens/splash/splash_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/utils/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'theme/AppTheme.dart';

final getIt = GetIt.instance;
NavigationService navService;
String appCurrencySymbol;

void setupDependencies() {
  getIt.registerLazySingleton<Dio>(() => DioHttpClient.getInstance());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerSingleton(FlutterSecureStorage());
  getIt.registerSingleton(NavigationService());

  // repositories
  getIt.registerSingleton(UserRepository());
  getIt.registerLazySingleton(() => CategoryRepository());
  getIt.registerLazySingleton(() => ProductRepository());
  getIt.registerLazySingleton(() => WishListRepository());
  getIt.registerLazySingleton(() => CartRepository());
  getIt.registerLazySingleton(() => OrderRepository());
  getIt.registerLazySingleton(() => CurrencyRepository());
  getIt.registerLazySingleton(() => InvoiceRepository());
  getIt.registerLazySingleton(() => HomeSlidesRepository());
  getIt.registerLazySingleton(() => BannerRepository());
  getIt.registerLazySingleton(() => BrandRepository());
}

void main() {
  setupDependencies();
  startApp();
}

startApp() async {
  navService = getIt<NavigationService>();
  // to show transparent status bar on Android
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: AppColors.red,
        statusBarIconBrightness: Brightness.light),
  );
// Set Portrait Mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(
      EasyLocalization(
        supportedLocales: [Locale('ar'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('ar'),
        startLocale: Locale('ar'),
        child: FadSheeApp(),
      ),
    );
  });
}

class FadSheeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: ProviderManager.providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: child,
            );
          },
          home: SplashScreen(),
          theme: AppTheme.getTheme(),
          navigatorKey: NavigationService.navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: (routeSettings) =>
              RoutesManager().onGenerate(routeSettings),
        ));
  }
}
