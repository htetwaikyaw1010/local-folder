import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/constant/dimesions.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/provider/order/order_provider.dart';
import 'package:bandula/core/viewobject/common/master_value_holder.dart';
import '../../../config/master_colors.dart';
import '../../../core/repository/order_repository.dart';
import '../../../core/utils/utils.dart';
import '../../../core/viewobject/holder/request_path_holder.dart';
import '../../common/call_login_view.dart';
import '../widgets/order_history/order_canceled_view.dart';
import '../widgets/order_history/order_completed_view.dart';
import '../widgets/order_history/order_pending_view.dart';
import '../widgets/order_history/order_confirmed_view.dart';
import '../widgets/order_history/order_refund_view.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final MasterValueHolder valueHolder =
        Provider.of<MasterValueHolder>(context);

    final OrderRepository repository = Provider.of<OrderRepository>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrderProvier>(
            lazy: false,
            create: (BuildContext context) {
              OrderProvier orderProvier = OrderProvier(repo: repository);
              orderProvier.loadDataList(
                requestPathHolder:
                    RequestPathHolder(headerToken: valueHolder.loginUserToken),
              );
              return orderProvier;
            }),
      ],
      child: Utils.isLogined(valueHolder)
          ? DefaultTabController(
              length: 5,
              child: Scaffold(
                backgroundColor: MasterColors.grey,
                appBar: AppBar(
                  backgroundColor: MasterColors.grey,
                  toolbarHeight: 0,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        indicatorColor: MasterColors.black,
                        indicatorWeight: 1.0,
                        isScrollable: true,
                        unselectedLabelColor: Colors.grey[500],
                        labelColor: MasterColors.black,
                        labelPadding:
                            EdgeInsets.symmetric(horizontal: Dimesion.height10),
                        indicatorSize: TabBarIndicatorSize.label,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w500),
                        tabs: [
                          Tab(
                            text: 'pending'.tr,
                          ),
                          Tab(
                            text: 'confrimed'.tr,
                          ),
                          Tab(
                            text: 'completed'.tr,
                          ),
                          Tab(
                            text: 'refund'.tr,
                          ),
                          Tab(
                            text: 'reject'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  title: const Text('Tabs Demo'),
                ),
                body: const TabBarView(
                  children: [
                    PendingOrderView(),
                    ConfirmedOrderView(),
                    CompletedOrderView(),
                    RefundOrderView(),
                    CanceledOrderView(),
                  ],
                ),
              ),
            )
          : const CallLoginView(),
    );
  }
}
