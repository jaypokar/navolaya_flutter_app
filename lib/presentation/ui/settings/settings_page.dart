import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/route_generator.dart';

import '../../../core/color_constants.dart';
import '../../../resources/string_resources.dart';
import '../../basicWidget/custom_button.dart';
import '../../basicWidget/divider_and_space_widget.dart';
import 'widget/privacy_settings_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          StringResources.settings,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ExpandablePanel(
              theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  iconPadding: EdgeInsets.symmetric(vertical: 5)),
              header: const Text(
                StringResources.generalSettings,
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
              ),
              collapsed: const SizedBox.shrink(),
              expanded: Row(
                children: [
                  const Text(
                    StringResources.allowNotifications,
                    style: TextStyle(
                      color: ColorConstants.textColor3,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Transform.translate(
                    offset: const Offset(10, 0),
                    child: Transform.scale(
                      scale: 0.5,
                      child: CupertinoSwitch(
                        value: _switchValue,
                        onChanged: (bool value) {
                          setState(() {
                            _switchValue = value;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            const DividerAndSpaceWidget(),
            ExpandablePanel(
              theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  iconPadding: EdgeInsets.symmetric(vertical: 5)),
              header: const Text(
                StringResources.privacySettings,
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
              ),
              collapsed: const SizedBox.shrink(),
              expanded: const PrivacySettingsWidget(),
            ),
            const DividerAndSpaceWidget(),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    StringResources.changePassword,
                    style:
                        TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  Icon(
                    Icons.navigate_next,
                    color: ColorConstants.navigateIconColor,
                    size: 28,
                  )
                ],
              ),
            ),
            const DividerAndSpaceWidget(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.blockedUserPage);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    StringResources.blockedUsers,
                    style:
                        TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  Icon(
                    Icons.navigate_next,
                    color: ColorConstants.navigateIconColor,
                    size: 28,
                  )
                ],
              ),
            ),
            const DividerAndSpaceWidget(),
            ExpandablePanel(
              theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  iconPadding: EdgeInsets.symmetric(vertical: 5)),
              header: const Text(
                StringResources.generalSettings,
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
              ),
              collapsed: const SizedBox.shrink(),
              expanded: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: ColorConstants.red),
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: const Text(
                  StringResources.deleteAccount,
                  style: TextStyle(
                      color: ColorConstants.red, fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
            ),
            const DividerAndSpaceWidget(),
            ButtonWidget(
              buttonText: StringResources.update,
              onPressButton: () {},
            )
          ],
        ),
      ),
    );
  }
}
