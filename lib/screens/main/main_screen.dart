import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/models/ui/bottom_nav_item_model.dart';
import 'package:fad_shee/screens/account/account_provider.dart';
import 'package:fad_shee/screens/account/account_screen.dart';
import 'package:fad_shee/screens/cart/cart_screen.dart';
import 'package:fad_shee/screens/categories/categories_provider.dart';
import 'package:fad_shee/screens/categories/categories_screen.dart';
import 'package:fad_shee/screens/home/home_provider.dart';
import 'package:fad_shee/screens/home/home_screen.dart';
import 'package:fad_shee/screens/main/main_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  AnimationController _animationController;
  int transitionInMillis = 500;
  List<BottomNavItemModel> bottomNavItems;
  MainProvider provider;

  Widget _getPageByIndex() {
    switch (_selectedIndex) {
      case 0:
        return ChangeNotifierProvider(
          create: (ctx) => HomeProvider(),
          child: HomeScreen(),
        );
      case 1:
        return ChangeNotifierProvider(
          create: (ctx) => CategoriesProvider({'category_id': null}),
          child: CategoriesScreen(),
        );
      case 2:
        return CartScreen(
          showBack: false,
        );
      default:
        return ChangeNotifierProvider(
          create: (ctx) => AccountProvider(),
          child: AccountScreen(),
        );
    }
  }

  BottomNavigationBarItem _buildBottomNavigationItem(BottomNavItemModel item) => BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Image.asset(
          item.icon,
          width: 25,
          color: AppColors.grey,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Image.asset(item.icon, width: 25, color: AppColors.lightRed),
      ),
      label: item.title);

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: transitionInMillis));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setupBottomNavItems();
    provider = Provider.of<MainProvider>(context);
    return provider.loading
        ? initialLoading()
        : provider.errorMessage != null
            ? errorText(provider.errorMessage)
            : Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 5,
                  items: [...bottomNavItems.map((e) => _buildBottomNavigationItem(e))],
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  onTap: (index) {
                    if (index == _selectedIndex) return;
                    setState(() {
                      _selectedIndex = index;
                    });
                    _animationController.forward(from: 0);
                  },
                  selectedFontSize: 12,
                  selectedIconTheme: IconThemeData(color: AppColors.red),
                  selectedItemColor: Colors.black,
                  unselectedFontSize: 12,
                  unselectedItemColor: AppColors.grey,
                  iconSize: 40,
                ),
                body: FadeTransition(
                  opacity: _animationController,
                  child: _getPageByIndex(),
                ),
              );
  }

  initialLoading() => Center(
        child: SpinKitChasingDots(color: AppColors.midGrey),
      );

  errorText(text) => Scaffold(
        body: Center(
          child: Text(text),
        ),
      );

  setupBottomNavItems() {
    bottomNavItems = [
      BottomNavItemModel(
        title: 'home'.tr(),
        icon: 'assets/images/ic_home.png',
      ),
      BottomNavItemModel(
        title: 'categories'.tr(),
        icon: 'assets/images/ic_categories_not_selected.png',
      ),
      BottomNavItemModel(
        title: 'cart'.tr(),
        icon: 'assets/images/ic_bag_not_selected.png',
      ),
      BottomNavItemModel(
        title: 'account'.tr(),
        icon: 'assets/images/ic_account_not_selected.png',
      ),
    ];
  }
}
