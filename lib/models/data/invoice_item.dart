class InvoiceItem {
  final String title;
  final double price;

  InvoiceItem({this.title, this.price});

  factory InvoiceItem.fromJson(Map<String, dynamic> data) {
    return InvoiceItem(
      title: data['title'],
      price: double.parse(data['price']),
    );
  }
}
