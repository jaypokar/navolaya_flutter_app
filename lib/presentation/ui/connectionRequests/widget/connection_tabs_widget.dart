import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../uiNotifiers/ui_notifiers.dart';

class ConnectionTabsWidget extends StatefulWidget {
  const ConnectionTabsWidget({Key? key}) : super(key: key);

  @override
  State<ConnectionTabsWidget> createState() => _ConnectionTabsWidgetState();
}

class _ConnectionTabsWidgetState extends State<ConnectionTabsWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      /*if(_tabController.index == 0){
        context.read<ConnectionReceivedCubit>().resetData();
      }else {

      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: const Offset(0.0, 5.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child: TabBar(
        indicatorColor: ColorConstants.appColor,
        labelColor: ColorConstants.textColor6,
        controller: _tabController,
        unselectedLabelColor: ColorConstants.textColor2,
        indicator: BoxDecoration(color: Colors.black12.withOpacity(0.1)),
        onTap: (index) => sl<UiNotifiers>().connectionRequestTabNotifier.value = index,
        tabs: ['Received Requests', 'Sent Requests']
            .map((e) => Tab(child: Text(e, style: const TextStyle(fontSize: 16))))
            .toList(),
      ),
    );
  }
}
