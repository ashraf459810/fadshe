class PaymentMethod {
  final int id;
  final String name;
  final bool isEnabled;

  PaymentMethod(this.id, this.name, {this.isEnabled = true});
}
