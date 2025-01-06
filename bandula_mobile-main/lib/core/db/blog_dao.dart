// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';
import 'package:bandula/core/viewobject/blog.dart';
import 'common/master_dao.dart';

class BlogDao extends MasterDao<Blog> {
  BlogDao._() {
    init(Blog());
  }

  static const String STORE_NAME = 'HomeBlog';
  final String _primaryKey = 'image';
  // Singleton instance
  static final BlogDao _singleton = BlogDao._();

  // Singleton accessor
  static BlogDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(Blog object) {
    return object.photo.toString();
  }

  @override
  Filter getFilter(Blog object) {
    return Filter.equals(_primaryKey, object.photo);
  }
}
