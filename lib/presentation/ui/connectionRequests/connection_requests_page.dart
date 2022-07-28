import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/presentation/cubit/connectionReceivedCubit/connection_received_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/connectionRequests/widget/connection_received_request_widget.dart';
import 'package:navolaya_flutter/presentation/ui/connectionRequests/widget/connection_sent_request_widget.dart';
import 'package:navolaya_flutter/presentation/ui/connectionRequests/widget/connection_tabs_widget.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../injection_container.dart';
import '../../cubit/connectionSentCubit/connection_sent_cubit.dart';
import '../../uiNotifiers/ui_notifiers.dart';

class ConnectionRequestsPage extends StatefulWidget {
  const ConnectionRequestsPage({Key? key}) : super(key: key);

  @override
  State<ConnectionRequestsPage> createState() => _ConnectionRequestsPageState();
}

class _ConnectionRequestsPageState extends State<ConnectionRequestsPage> {
  late List<Widget> _widgetOptions;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      const ConnectionReceivedRequestWidget(
        key: PageStorageKey('connection-received'),
      ),
      const ConnectionSentRequestWidget(
        key: PageStorageKey('connection-sent'),
      ),
    ];

    sl<UiNotifiers>().createConnectionRequestTabNotifier();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConnectionReceivedCubit, ConnectionReceivedState>(
          listener: (_, state) {
            if (state is ErrorLoadingConnectionReceivedState) {
              sl<CommonFunctions>().showSnackBar(
                context: context,
                message: state.message,
                bgColor: ColorConstants.red,
                textColor: Colors.white,
              );
            } else if (state is UpdateReceivedConnectionState) {
              sl<CommonFunctions>().showSnackBar(
                context: context,
                message: state.createOrUpdateConnectionRequestResponse.message!,
                bgColor: Colors.green,
                textColor: Colors.white,
              );
            }
          },
        ),
        BlocListener<ConnectionSentCubit, ConnectionSentState>(
          listener: (_, state) {
            if (state is ErrorLoadingConnectionSentState) {
              sl<CommonFunctions>().showSnackBar(
                context: context,
                message: state.message,
                bgColor: ColorConstants.red,
                textColor: Colors.white,
              );
            } else if (state is UpdateSentConnectionState) {
              sl<CommonFunctions>().showSnackBar(
                context: context,
                message: state.createOrUpdateConnectionRequestResponse.message!,
                bgColor: Colors.green,
                textColor: Colors.white,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            StringResources.connectionRequests,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            const ConnectionTabsWidget(),
            Expanded(
              child: ValueListenableBuilder<int>(
                  valueListenable: sl<UiNotifiers>().connectionRequestTabNotifier,
                  builder: (_, pos, __) {
                    return PageStorage(
                      bucket: _bucket,
                      child: _widgetOptions[pos],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    sl<UiNotifiers>().connectionRequestTabNotifier.dispose();
    super.dispose();
  }
}
