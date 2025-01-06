// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';

import '../viewobject/banner.dart';
import 'common/master_dao.dart';

class BannerDao extends MasterDao<HomeBanner> {
  BannerDao._() {
    init(HomeBanner());
  }

  static const String STORE_NAME = 'HomeBanner';
  final String _primaryKey = 'image';
  // Singleton instance
  static final BannerDao _singleton = BannerDao._();

  // Singleton accessor
  static BannerDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(HomeBanner object) {
    return object.image.toString();
  }

  @override
  Filter getFilter(HomeBanner object) {
    return Filter.equals(_primaryKey, object.image);
  }
}
