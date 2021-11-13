import 'package:fad_shee/providers/cart_provider.dart';
import 'package:fad_shee/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderManager {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (ctx) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (ctx) => CartProvider(),
    ),
  ];
}
