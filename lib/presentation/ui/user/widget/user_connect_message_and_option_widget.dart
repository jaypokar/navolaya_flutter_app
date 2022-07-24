import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../core/color_constants.dart';

class UserConnectMessageAndOptionWidget extends StatefulWidget {
  final UserDataModel user;

  const UserConnectMessageAndOptionWidget({required this.user, Key? key}) : super(key: key);

  @override
  State<UserConnectMessageAndOptionWidget> createState() =>
      _UserConnectMessageAndOptionWidgetState();
}

class _UserConnectMessageAndOptionWidgetState extends State<UserConnectMessageAndOptionWidget> {
  String connectOrPending = '';

  @override
  void initState() {
    super.initState();
    if (widget.user.isConnected != null) {
      if (!widget.user.isConnected!) {
        connectOrPending = StringResources.connect;
      }
    }
    if (widget.user.isRequestSent != null) {
      if (widget.user.isRequestSent!) {
        connectOrPending = StringResources.pending;
      }
    }
    if (widget.user.isRequestReceived != null) {
      if (widget.user.isRequestReceived!) {
        connectOrPending = StringResources.respond;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        connectOrPending.isEmpty
            ? const SizedBox.shrink()
            : Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    side: const BorderSide(width: 1.0, color: ColorConstants.appColor),
                  ),
                  child: Text(
                    connectOrPending,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              side: const BorderSide(
                width: 1.0,
                color: ColorConstants.appColor,
              ),
            ),
            child: const Text(
              StringResources.message,
              style: TextStyle(
                  color: ColorConstants.appColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.more_horiz)),
      ],
    );
  }
}
