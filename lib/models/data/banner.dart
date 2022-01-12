class Banner {
  final int id;
  final String imageUrl;
  final String text;
  final BannerPlace bannerPlace;
  final String link;

  Banner({this.id, this.imageUrl, this.text, this.bannerPlace, this.link});

  factory Banner.fromJson(Map<String, dynamic> data) {
    return Banner(
      id: data['id'],
      link: data['link'],
      imageUrl: data['image'],
      text: data['text'],
      bannerPlace: (data['banner_places_id'] as int) == 1
          ? BannerPlace.MAIN_PAGE_UPPER
          : data['banner_places_id'] == 2
              ? BannerPlace.MAIN_PAGE_LOWER
              : BannerPlace.CATEGORY_PAGE,
    );
  }
}

enum BannerPlace { MAIN_PAGE_UPPER, MAIN_PAGE_LOWER, CATEGORY_PAGE }
