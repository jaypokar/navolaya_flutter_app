import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/presentation/cubit/dashBoardTabChangeNotifier/dash_board_tab_change_notifier_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/recentUsersCubit/recent_users_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/bottom_sheet_filter_widget.dart';
import 'package:navolaya_flutter/resources/value_key_resources.dart';

import '../../../../data/model/filter_data_request_model.dart';
import '../../../cubit/homeTabsNotifierCubit/home_tabs_notifier_cubit.dart';
import '../../../cubit/nearByUsersCubit/near_by_users_cubit.dart';
import '../../../cubit/popularUsersCubit/popular_users_cubit.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({Key? key}) : super(key: key);

  @override
  State<FloatingActionButtonWidget> createState() => _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState extends State<FloatingActionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(0.0, 22.0),
          child: GestureDetector(
            onTap: () {},
            child: const SizedBox(
              height: 80,
              width: 100,
              child: Text(''),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0.0, 18.0),
          child: SizedBox(
            height: 62,
            width: 62,
            child: FloatingActionButton(
              onPressed: () => callBottomSheet(),
              elevation: 2,
              shape: const StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void callBottomSheet() async {
    final blocNearByUserCubit = context.read<NearByUsersCubit>();
    final result = await showModalBottomSheet(
        /*constraints: BoxConstraints.loose(
            Size(MediaQuery.of(context).size.width, 687)),*/
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (_) {
          return BlocProvider<NearByUsersCubit>.value(
            value: blocNearByUserCubit,
            child: const BottomSheetFilterWidget(),
          );
        });

    if (result != null) {
      Map<String, dynamic> filters = result as Map<String, dynamic>;
      applyFilterOrClear(
          filters[ValueKeyResources.filterDataKey],
          filters[ValueKeyResources.isApplyFilterKey],
          filters[ValueKeyResources.isSearchByLocality]);
    }
  }

  void applyFilterOrClear(
      FilterDataRequestModel filterData, bool applyFilter, bool isSearchByLocality) async {
    if (!applyFilter) {
      await context.read<RecentUsersCubit>().clearFilter();
    }

    if (!mounted) return;
    if (context.read<DashBoardTabChangeNotifierCubit>().state != 0) {
      context.read<DashBoardTabChangeNotifierCubit>().changeTab(0);
    }
    context.read<RecentUsersCubit>().filterList(filterData: filterData);
    context.read<PopularUsersCubit>().filterList(filterData: filterData);

    if (!applyFilter) {
      await context.read<NearByUsersCubit>().handleUserLocation();
    }
    if (!mounted) return;
    context.read<NearByUsersCubit>().filterList(filterData: filterData);

    logger.i('$isSearchByLocality');
    if (isSearchByLocality) {
      context.read<HomeTabsNotifierCubit>().changeHomeTabs(1);
    }
  }
}
