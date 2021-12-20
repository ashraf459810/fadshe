import 'package:fad_shee/repositories/user_repository.dart';
import 'package:fad_shee/screens/account/widgets/InvitesWebView.dart';
import 'package:fad_shee/screens/blocked_user.dart';
import 'package:fad_shee/screens/cart/cart_screen.dart';
import 'package:fad_shee/screens/categories/categories_provider.dart';
import 'package:fad_shee/screens/categories/subcategories_screen.dart';
import 'package:fad_shee/screens/category_details/category_details_provider.dart';
import 'package:fad_shee/screens/category_details/category_details_screen.dart';
import 'package:fad_shee/screens/checkout/checkout_provider.dart';
import 'package:fad_shee/screens/checkout/checkout_screen.dart';
import 'package:fad_shee/screens/currencies/currencies_provider.dart';
import 'package:fad_shee/screens/currencies/currencies_screen.dart';
import 'package:fad_shee/screens/invoice_details/invoice_details_provider.dart';
import 'package:fad_shee/screens/invoice_details/invoice_details_screen.dart';
import 'package:fad_shee/screens/languages/languages_screen.dart';
import 'package:fad_shee/screens/login/login_provider.dart';
import 'package:fad_shee/screens/login/login_screen.dart';
import 'package:fad_shee/screens/main/main_provider.dart';
import 'package:fad_shee/screens/main/main_screen.dart';
import 'package:fad_shee/screens/order_details/order_details_provider.dart';
import 'package:fad_shee/screens/order_details/order_details_screen.dart';
import 'package:fad_shee/screens/orders/orders_provider.dart';
import 'package:fad_shee/screens/orders/orders_screen.dart';
import 'package:fad_shee/screens/payment/payment_provider.dart';
import 'package:fad_shee/screens/payment/payment_screen.dart';
import 'package:fad_shee/screens/product_details/product_details_provider.dart';
import 'package:fad_shee/screens/product_details/product_details_screen.dart';
import 'package:fad_shee/screens/profile/edit_profile_screen.dart';
import 'package:fad_shee/screens/profile/profile_screen.dart';
import 'package:fad_shee/screens/register/register_provider.dart';
import 'package:fad_shee/screens/register/register_screen.dart';
import 'package:fad_shee/screens/search/search_provider.dart';
import 'package:fad_shee/screens/search/search_screen.dart';
import 'package:fad_shee/screens/wishlist/wishlist_provider.dart';
import 'package:fad_shee/screens/wishlist/wishlist_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class RoutesManager {
  UserRepository userRepo = getIt<UserRepository>();

  PageRouteBuilder onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case MainScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ChangeNotifierProvider(
            create: (ctx) => MainProvider(),
            child: MainScreen(),
          ),
          settings: routeSettings,
        );
      case LoginScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (ctx) => LoginProvider()),
                  ],
                  child: LoginScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);

      case InvitesWebView.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                InvitesWebView(
                  token: userRepo.token,
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);

      case RegisterScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (ctx) => RegisterProvider()),
                  ],
                  child: RegisterScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case OrdersScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChangeNotifierProvider(
                  create: (ctx) => OrdersProvider(),
                  child: OrdersScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case LanguagesScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                LanguagesScreen(),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case CurrenciesScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChangeNotifierProvider(
                  create: (ctx) => CurrenciesProvider(),
                  child: CurrenciesScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case ProductDetailsScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChangeNotifierProvider(
                  create: (ctx) =>
                      ProductDetailsProvider(routeSettings.arguments),
                  child: ProductDetailsScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case SubcategoriesScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChangeNotifierProvider(
                  create: (ctx) => CategoriesProvider(routeSettings.arguments),
                  child: SubcategoriesScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case ProfileScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ProfileScreen(),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case CategoryDetailsScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChangeNotifierProvider(
                  create: (ctx) =>
                      CategoryDetailsProvider(routeSettings.arguments),
                  child: CategoryDetailsScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case WishListScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChangeNotifierProvider(
                  create: (ctx) => WishListProvider(),
                  child: WishListScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case OrderDetailsScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChangeNotifierProvider(
                  create: (ctx) =>
                      OrderDetailsProvider(routeSettings.arguments),
                  child: OrderDetailsScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case CheckoutScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChangeNotifierProvider(
                  create: (ctx) => CheckoutProvider(),
                  child: CheckoutScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToTopTransition);
      case EditProfileScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                EditProfileScreen(),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case CartScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CartScreen(),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case SearchScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChangeNotifierProvider(
                  create: (ctx) => SearchProvider(),
                  child: SearchScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToTopTransition);
      case BlockedUserScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BlockedUserScreen(),
          settings: routeSettings,
        );
      case PaymentScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChangeNotifierProvider(
                  create: (ctx) => PaymentProvider(routeSettings.arguments),
                  child: PaymentScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      case InvoiceDetailsScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChangeNotifierProvider(
                  create: (ctx) =>
                      InvoiceDetailsProvider(routeSettings.arguments),
                  child: InvoiceDetailsScreen(),
                ),
            settings: routeSettings,
            transitionsBuilder: _slideToStartTransition);
      default:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MainScreen());
    }
  }

  Widget _slideToStartTransition(
      context, animation, secondaryAnimation, child) {
    var begin = Offset(1.0, 0.0);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end);
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  Widget _slideToTopTransition(context, animation, secondaryAnimation, child) {
    var begin = Offset(0.0, 1.0);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end);
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
