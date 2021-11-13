class Brand {
  final int id;
  final String imageUrl;

  Brand({this.id, this.imageUrl});

  factory Brand.fromJson(Map<String, dynamic> data) {
    return Brand(
      id: data['id'],
      imageUrl: data['image'],
    );
  }
}
