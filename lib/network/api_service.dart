import 'package:fad_shee/models/data/cities_model.dart';
import 'package:fad_shee/network/endpoints/authentication.dart';
import 'package:fad_shee/network/endpoints/banners.dart';
import 'package:fad_shee/network/endpoints/brands.dart';
import 'package:fad_shee/network/endpoints/cart.dart';
import 'package:fad_shee/network/endpoints/categories.dart';
import 'package:fad_shee/network/endpoints/currencies.dart';
import 'package:fad_shee/network/endpoints/get_cities.dart';
import 'package:fad_shee/network/endpoints/home_slides.dart';
import 'package:fad_shee/network/endpoints/invoices.dart';
import 'package:fad_shee/network/endpoints/orders.dart';
import 'package:fad_shee/network/endpoints/payment.dart';
import 'package:fad_shee/network/endpoints/products.dart';
import 'package:fad_shee/network/endpoints/user.dart';
import 'package:fad_shee/network/endpoints/wish_list.dart';

class ApiService {
  Authentication authentication = Authentication();
  UserInfo user = UserInfo();
  Categories categories = Categories();
  Products products = Products();
  WishList wishList = WishList();
  Cart cart = Cart();
  Orders orders = Orders();
  Currencies currencies = Currencies();
  Invoices invoices = Invoices();
  Payment payment = Payment();
  HomeSlides homeSlides = HomeSlides();
  Banners banners = Banners();
  Brands brands = Brands();
  GetCities cities = GetCities();
}
