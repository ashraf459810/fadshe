class CarouselPageData {
  final String imageUrl;
  final String text;

  final String link;
  CarouselPageData({this.imageUrl, this.text, this.link});

  factory CarouselPageData.fromJson(Map<String, dynamic> data) {
    return CarouselPageData(
        imageUrl: data['image'], text: data['text'], link: data['link']);
  }
}
