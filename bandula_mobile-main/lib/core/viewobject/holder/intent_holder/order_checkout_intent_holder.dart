class OrderCheckoutIntentHolder {
  const OrderCheckoutIntentHolder({
    required this.region,
    required this.name,
    required this.phone,
    required this.address,
    required this.totalFee,
    required this.fees,
    required this.paymentName,
  });

  final String region;
  final String name;
  final String phone;
  final String address;
  final String totalFee;
  final String fees;
  final String paymentName;
}
