import 'package:flutter/material.dart';

class ConnectionSentRequestWidget extends StatelessWidget {
  const ConnectionSentRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox
            .shrink() /*ListView.separated(
        itemBuilder: (_, i) {
          return const MyConnectionsItemWidget(
            connectionsType: ConnectionsType.connectionsSent,
          );
        },
        separatorBuilder: (_, i) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 1,
              color: Colors.grey,
            ),
          );
        },
        itemCount: 10)*/
        ;
  }
}
