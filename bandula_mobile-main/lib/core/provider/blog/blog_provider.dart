import 'package:bandula/core/api/common/master_resource.dart';
import 'package:bandula/core/constant/master_constants.dart';
import 'package:bandula/core/provider/common/master_provider.dart';
import 'package:bandula/core/repository/blog_repository.dart';
import 'package:bandula/core/viewobject/blog.dart';

class BlogProvider extends MasterProvider<Blog> {
  BlogProvider({
    required BlogReposistory repo,
    int limit = 0,
  }) : super(
          repo,
          limit,
          subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION,
        );
  MasterResource<List<Blog>> get blogList => super.dataList;
}
