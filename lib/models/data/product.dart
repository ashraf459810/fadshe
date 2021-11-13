import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/attribute.dart';
import 'package:fad_shee/models/data/comment.dart';
import 'package:fad_shee/repositories/category_repository.dart';
import 'package:fad_shee/repositories/user_repository.dart';
import 'package:fad_shee/repositories/wish_list_repository.dart';
import 'package:fad_shee/screens/login/login_screen.dart';
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  @required
  final int id;
  final String title;
  final String description;
  final String images;
  final int quantity;
  final dynamic price;
  final double discount;
  final int categoryId;
  final List<Attribute> attributes;
  final List<Comment> comments;
  int rating;

  Product({
    this.id,
    this.title,
    this.description,
    this.images,
    this.quantity,
    this.price,
    this.discount,
    this.categoryId,
    this.attributes,
    this.comments,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> jsonData) {
    return Product(
        id: jsonData['id'],
        title: jsonData['title'],
        description: jsonData['description'],
        images: jsonData['images'],
        price: jsonData['price'],
        discount: jsonData['discount'].toDouble(),
        categoryId: jsonData['categories_id'],
        attributes: (jsonData['attribs'] as List)
                ?.map((e) => Attribute.fromJson(e))
                ?.toList() ??
            [],
        comments: (jsonData['comments'] as List)
                ?.map((e) => Comment.fromJson(e))
                ?.toList() ??
            [],
        rating: 10);
  }

  WishListRepository wishListRepo = getIt<WishListRepository>();

  bool get isFavorite => wishListRepo.isProductFavorite(id);
  bool loading = false;

  toggleFavorite() async {
    if (getIt<UserRepository>().isLoggedIn) {
      loading = true;
      await wishListRepo.toggleFavorite(this);
      loading = false;
      notifyListeners();
    } else {
      navService.pushNamed(LoginScreen.routeName);
    }
  }

  String get categoryName =>
      getIt<CategoryRepository>().getCategory(categoryId).title;
}
