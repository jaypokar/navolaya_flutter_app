import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/socketConnectionCubit/socket_connection_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/drawer_list_item_widget.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../data/sessionManager/session_manager.dart';
import '../../../../injection_container.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../bloc/authBloc/auth_bloc.dart';

class DashBoardDrawerWidget extends StatefulWidget {
  const DashBoardDrawerWidget({Key? key}) : super(key: key);

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
      {'icon': ImageResources.verificationIcon, 'title': StringResources.userVerificationRequests},
      {'icon': ImageResources.connectionsIcon, 'title': StringResources.connectionRequests},
      {'icon': ImageResources.settingsIcon, 'title': StringResources.settings},
      {'icon': ImageResources.helpInfoIcon, 'title': StringResources.helpAndInfo},
      {'icon': ImageResources.shareIcon, 'title': StringResources.shareTheApp},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            InkWell(
              onTap: () {
                Scaffold.of(context).closeDrawer();
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: Image.asset(
                      ImageResources.closeIcon,
                      height: 16,
                    )),
              ),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (_, state) {
                final userImage = sl<SessionManager>().getUserDetails()!.data!.userImage;
                String image = '';
                if (userImage != null) {
                  image = userImage.thumburl!;
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 65,
                        width: 65,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Container(
                            color: ColorConstants.appColor.withOpacity(0.4),
                            child: image.isEmpty
                                ? Image.asset(
                                    ImageResources.userAvatarImg,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sl<SessionManager>().getUserDetails()!.data!.fullName!,
                              maxLines: 1,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Wrap(
                              children: [
                                Text(
                                  'JNV ${sl<SessionManager>().getUserDetails()!.data!.school!.district!}\n${sl<SessionManager>().getUserDetails()!.data!.relationWithJnv!}',
                                  style: const TextStyle(fontSize: 12),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              itemBuilder: (_, i) {
                return DrawerListItemWidget(
                  title: drawerItemList[i]['title'].toString(),
                  icon: drawerItemList[i]['icon'].toString(),
                  index: i,
                  isHelpInfoIcon: i == 6,
                );
              },
              itemCount: drawerItemList.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 1,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
              if (state is AuthLoadingState) {
                return const LoadingWidget();
              } else {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      icon: Image.asset(
                        ImageResources.logoutIcon,
                        color: Colors.white,
                        height: 16,
                        width: 16,
                      ),
                      onPressed: () async {
                        context.read<AuthBloc>().add(const InitiateLogout());
                        context.read<SocketConnectionCubit>().closeSocketConnection();
                        await sl<SessionManager>().initiateLogout();

                        /*if (mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              RouteGenerator.authenticationPage, (route) => false);
                        }*/
                      },
                      label: Text(
                        StringResources.logout.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.appColor,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        /*minimumSize: const Size.fromHeight(40),*/
                      ),
                    ),
                  ),
                );
              }
            }),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.6),
                        Colors.white.withOpacity(0.6),
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Image.asset(
                    ImageResources.textLogo,
                    /*height: 300,
                    width: 300,*/
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
