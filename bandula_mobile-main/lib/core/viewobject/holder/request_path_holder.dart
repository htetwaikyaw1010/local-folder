class RequestPathHolder {
  RequestPathHolder({
    this.itemId,
    this.regionId,
    this.currentPage,
    this.orderId,
    this.headerToken,
    this.fcmToken,
  });

  final String? currentPage;
  final String? itemId;
  final String? regionId;
  final String? orderId;
  final String? headerToken;
  final String? fcmToken;
}
