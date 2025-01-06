import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:bandula/core/db/blog_dao.dart';
import 'package:bandula/core/db/cpu_dao.dart';
import 'package:bandula/core/db/generation_dao.dart';
import 'package:bandula/core/db/noti_dao.dart';
import 'package:bandula/core/db/order_dao.dart';
import 'package:bandula/core/db/payment_dao.dart';
import 'package:bandula/core/db/region_dao.dart';
import 'package:bandula/core/db/search_keyword_dao.dart';
import 'package:bandula/core/repository/blog_repository.dart';
import 'package:bandula/core/repository/comp_cpu_repository.dart';
import 'package:bandula/core/repository/generation_repository.dart';
import 'package:bandula/core/repository/noti_list_reposistory.dart';
import 'package:bandula/core/repository/order_repository.dart';
import 'package:bandula/core/repository/region_repository.dart';
import 'package:bandula/core/repository/township_repository.dart';
import '../api/master_api_service.dart';
import '../db/banner_dao.dart';
import '../db/brand_dao.dart';
import '../db/cart_product_dao.dart';
import '../db/category_dao.dart';
import '../db/common/master_shared_preferences.dart';
import '../db/language_dao.dart';
import '../db/order_details_dao.dart';
import '../db/product_dao.dart';
import '../db/township_dao.dart';
import '../db/user_dao.dart';
import '../repository/Common/language_repository.dart';
import '../repository/banner_repository.dart';
import '../repository/brand_repository.dart';
import '../repository/card_repository.dart';
import '../repository/cateogry_repository.dart';
import '../repository/order_details_repository.dart';
import '../repository/payment_repository.dart';
import '../repository/product_repository.dart';
import '../repository/search_keyword_repository.dart';
import '../repository/user_repository.dart';
import '../viewobject/common/master_value_holder.dart';

List<SingleChildWidget> providers = <SingleChildWidget>[
  ...independentProviders,
  ..._dependentProviders,
  ..._valueProviders,
];

List<SingleChildWidget> independentProviders = <SingleChildWidget>[
  Provider<MasterSharedPreferences>.value(
      value: MasterSharedPreferences.instance),
  Provider<MasterApiService>.value(value: MasterApiService()),
  Provider<LanguageDao>.value(value: LanguageDao.instance),
  Provider<UserDao>.value(value: UserDao.instance),
  Provider<BannerDao>.value(value: BannerDao.instance),
  Provider<CateogryDao>.value(value: CateogryDao.instance),
  Provider<BrandDao>.value(value: BrandDao.instance),
  Provider<ProductDao>.value(value: ProductDao.instance),
  Provider<CartProductDao>.value(value: CartProductDao.instance),
  Provider<CompCPUDao>.value(value: CompCPUDao.instance),
  Provider<GenerationDao>.value(value: GenerationDao.instance),
  Provider<RegionDao>.value(value: RegionDao.instance),
  Provider<TownshipDao>.value(value: TownshipDao.instance),
  Provider<PaymentDao>.value(value: PaymentDao.instance),
  Provider<OrderDao>.value(value: OrderDao.instance),
  Provider<BlogDao>.value(value: BlogDao.instance),
  Provider<OrderDetailsDao>.value(value: OrderDetailsDao.instance),
  Provider<SearchKeywordDao>.value(value: SearchKeywordDao.instance),
  Provider<NotiDao>.value(value: NotiDao.instace),
];

List<SingleChildWidget> _dependentProviders = <SingleChildWidget>[
  ProxyProvider3<MasterSharedPreferences, MasterApiService, UserDao,
      UserRepository>(
    update: (_,
            MasterSharedPreferences sharedPreferences,
            MasterApiService apiService,
            UserDao userDao,
            UserRepository? userRepository) =>
        UserRepository(
      sharedPreferences: sharedPreferences,
      apiService: apiService,
      userDao: userDao,
    ),
  ),
  ProxyProvider2<MasterApiService, BannerDao, BannerRepository>(
    update: (_, MasterApiService apiService, BannerDao dao,
            BannerRepository? bannerRepository) =>
        BannerRepository(apiService: apiService, dao: dao),
  ),
  ProxyProvider2<MasterApiService, NotiDao, NotiListReposistory>(
    update: (_, MasterApiService apiService, NotiDao dao,
            NotiListReposistory? bannerRepository) =>
        NotiListReposistory(apiService: apiService, dao: dao),
  ),
  ProxyProvider2<MasterApiService, CateogryDao, CategoryRepository>(
    update: (_, MasterApiService apiService, CateogryDao dao,
            CategoryRepository? bannerRepository) =>
        CategoryRepository(apiService: apiService, dao: dao),
  ),
  ProxyProvider2<MasterApiService, BrandDao, BrandRepository>(
    update: (_, MasterApiService apiService, BrandDao dao,
            BrandRepository? bannerRepository) =>
        BrandRepository(apiService: apiService, dao: dao),
  ),
  ProxyProvider2<MasterApiService, ProductDao, ProductRepository>(
    update: (_, MasterApiService apiService, ProductDao dao,
            ProductRepository? bannerRepository) =>
        ProductRepository(apiService: apiService, dao: dao),
  ),
  ProxyProvider2<MasterApiService, RegionDao, RegionRepository>(
    update: (_, MasterApiService apiService, RegionDao dao,
            RegionRepository? repository) =>
        RegionRepository(apiService: apiService, dao: dao),
  ),
  ProxyProvider2<MasterApiService, CompCPUDao, CompCPURepository>(
    update: (_, MasterApiService apiService, CompCPUDao dao,
            CompCPURepository? repository) =>
        CompCPURepository(apiService: apiService, dao: dao),
  ),
  ProxyProvider2<MasterApiService, GenerationDao, GenerationRepository>(
    update: (_, MasterApiService apiService, GenerationDao dao,
            GenerationRepository? repository) =>
        GenerationRepository(apiService: apiService, dao: dao),
  ),
  ProxyProvider2<MasterApiService, TownshipDao, TownshipRepository>(
    update: (_, MasterApiService apiService, TownshipDao dao,
            TownshipRepository? repository) =>
        TownshipRepository(apiService: apiService, dao: dao),
  ),
  ProxyProvider2<MasterApiService, PaymentDao, PaymentRepository>(
    update: (_, MasterApiService apiService, PaymentDao dao,
            PaymentRepository? repository) =>
        PaymentRepository(apiService: apiService, dao: dao),
  ),
  ProxyProvider2<MasterApiService, CartProductDao, CartRepository>(
    update: (_, MasterApiService apiService, CartProductDao dao,
            CartRepository? cartRepository) =>
        CartRepository(dao: dao, apiService: apiService),
  ),
  ProxyProvider2<MasterApiService, OrderDao, OrderRepository>(
    update: (_, MasterApiService apiService, OrderDao dao,
            OrderRepository? repository) =>
        OrderRepository(dao: dao, apiService: apiService),
  ),
  ProxyProvider2<MasterApiService, BlogDao, BlogReposistory>(
    update: (_, MasterApiService apiService, BlogDao dao,
            BlogReposistory? repository) =>
        BlogReposistory(dao: dao, apiService: apiService),
  ),
  ProxyProvider2<MasterApiService, OrderDetailsDao, OrderDetailsRepository>(
    update: (_, MasterApiService apiService, OrderDetailsDao dao,
            OrderDetailsRepository? repository) =>
        OrderDetailsRepository(dao: dao, apiService: apiService),
  ),
  ProxyProvider<SearchKeywordDao, SearchKeywordRepository>(
    update: (_, SearchKeywordDao dao, SearchKeywordRepository? repository) =>
        SearchKeywordRepository(
      dao: dao,
    ),
  ),
  ProxyProvider2<MasterSharedPreferences, LanguageDao, LanguageRepository>(
    update: (_, MasterSharedPreferences ssSharedPreferences,
            LanguageDao languageDao, LanguageRepository? languageRepository) =>
        LanguageRepository(
            sharedPreferences: ssSharedPreferences, languageDao: languageDao),
  ),
];

List<SingleChildWidget> _valueProviders = <SingleChildWidget>[
  StreamProvider<MasterValueHolder?>(
    initialData: null,
    create: (BuildContext context) =>
        Provider.of<MasterSharedPreferences>(context, listen: false)
            .masterValueHolder,
  )
];
