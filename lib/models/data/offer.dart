class Offer {
  final String imageUrl;
  final int discountPercentage;

  Offer({this.imageUrl, this.discountPercentage});

  factory Offer.fromJson(Map<String, dynamic> jsonData) => Offer(
        imageUrl: jsonData['images'] != null
            ? 'https://imart.krd/imartAdmin/storage/offer_images/${jsonData['images']}'
            : null,
        discountPercentage: jsonData['discount'],
      );
}
