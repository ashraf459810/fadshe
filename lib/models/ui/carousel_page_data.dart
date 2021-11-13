class CarouselPageData {
  final String imageUrl;
  final String text;

  CarouselPageData({this.imageUrl, this.text});

  factory CarouselPageData.fromJson(Map<String, dynamic> data) {
    return CarouselPageData(
      imageUrl: data['image'],
      text: data['text'],
    );
  }
}
