import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../core/color_constants.dart';

enum ConnectionsType { myConnections, connectionsReceived, connectionsSent }

class MyConnectionsItemWidget extends StatelessWidget {
  final ConnectionsType connectionsType;

  const MyConnectionsItemWidget({required this.connectionsType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/1.jpg',
              ),
              radius: 35,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Jordan Nielson',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: const [
                      Icon(
                        FontAwesomeIcons.school,
                        color: ColorConstants.textColor3,
                        size: 14,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'ABC School',
                        style: TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: const [
                      Icon(
                        FontAwesomeIcons.link,
                        color: ColorConstants.textColor3,
                        size: 14,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Student',
                        style: TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            getActionWidget(),
          ],
        ),
      ),
    );
  }

  Widget getActionWidget() {
    if (connectionsType == ConnectionsType.myConnections) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorConstants.red),
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: const Text(
          StringResources.remove,
          style: TextStyle(color: ColorConstants.red, fontSize: 12),
        ),
      );
    } else if (connectionsType == ConnectionsType.connectionsReceived) {
      return Row(
        children: [
          Image.asset(
            ImageResources.cancelIcon,
            height: 25,
            width: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Image.asset(
            ImageResources.acceptIcon,
            height: 25,
            width: 25,
          ),
        ],
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorConstants.red),
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: const Text(
          StringResources.cancel,
          style: TextStyle(color: ColorConstants.red, fontSize: 12),
        ),
      );
    }
  }
}
