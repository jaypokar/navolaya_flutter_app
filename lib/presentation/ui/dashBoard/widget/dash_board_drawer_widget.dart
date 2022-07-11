import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/drawer_list_item_widget.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

class DashBoardDrawerWidget extends StatefulWidget {
  final TabController tabController;

  const DashBoardDrawerWidget({required this.tabController, Key? key}) : super(key: key);

  @override
  State<DashBoardDrawerWidget> createState() => _DashBoardDrawerWidgetState();
}

class _DashBoardDrawerWidgetState extends State<DashBoardDrawerWidget> {
  late final List<Map<String, String>> drawerItemList;

  @override
  void initState() {
    super.initState();
    drawerItemList = [
      {'icon': ImageResources.userIcon, 'title': StringResources.editProfile},
      {'icon': ImageResources.chatIcon, 'title': StringResources.messages},
      {'icon': ImageResources.groupIcon, 'title': StringResources.myConnections},
      {'icon': ImageResources.connectionsIcon, 'title': StringResources.connectionRequests},
      {'icon': ImageResources.settingsIcon, 'title': StringResources.settings},
      {'icon': ImageResources.helpInfoIcon, 'title': StringResources.helpAndInfo},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            ImageResources.closeIcon,
                            height: 16,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: Image.asset(
                              'assets/1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Jenova Eberhardt',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Student JNV Farmer',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemBuilder: (_, i) {
                  return DrawerListItemWidget(
                    title: drawerItemList[i]['title'].toString(),
                    icon: drawerItemList[i]['icon'].toString(),
                    index: i,
                    tabController: widget.tabController,
                  );
                },
                itemCount: drawerItemList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                icon: Image.asset(
                  ImageResources.logoutIcon,
                  color: Colors.white,
                  height: 17,
                  width: 17,
                ),
                onPressed: () {},
                label: Text(
                  StringResources.logout.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: ColorConstants.appColor,
                  padding: const EdgeInsets.all(10),
                  minimumSize: const Size.fromHeight(40),
                ),
              ),
            ),
            Expanded(
              child: Image.asset(
                ImageResources.textLogoGradient,
                height: 300,
                width: 300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
