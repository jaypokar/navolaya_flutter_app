import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/presentation/ui/myProfile/widgets/my_address_detail_widget.dart';
import 'package:navolaya_flutter/presentation/ui/myProfile/widgets/my_personal_and_education_widget.dart';
import 'package:navolaya_flutter/presentation/ui/myProfile/widgets/my_social_medial_widget.dart';

import '../../../injection_container.dart';
import '../../../resources/image_resources.dart';
import 'widgets/about_me_widget.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String image = '';
  late final Data userData;
  String userCurrentAddress = '';
  String userPermanentAddress = '';

  @override
  void initState() {
    super.initState();

    final data = sl<SessionManager>().getUserDetails()!;
    userData = data.data!;
    image =
        userData.userImage != null ? userData.userImage!.fileurl! : ImageResources.userAvatarImg;
    userCurrentAddress = userData.currentAddress ?? '';
    userPermanentAddress = userData.permanentAddress ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: false,
            expandedHeight: 460.0,
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                child: Container(
                  margin: const EdgeInsets.only(left: 6),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(''),
              background: image.contains('http')
                  ? ImageNetwork(
                      image: image,
                      imageCache: CachedNetworkImageProvider(image),
                      fitAndroidIos: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      onError:
                          Padding(padding: const EdgeInsets.all(60), child: Image.asset(image)),
                      onLoading:
                          Padding(padding: const EdgeInsets.all(60), child: Image.asset(image)),
                    )
                  : Padding(padding: const EdgeInsets.all(60), child: Image.asset(image)),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              MyPersonalAndEducationWidget(user: userData),
              const SizedBox(height: 5),
              const Divider(color: Colors.grey),
              const SizedBox(height: 5),
              if (userCurrentAddress.isNotEmpty || userPermanentAddress.isNotEmpty) ...[
                MyAddressDetailWidget(
                  userCurrentAddress: userCurrentAddress,
                  userPermanentAddress: userPermanentAddress,
                ),
                const SizedBox(height: 5),
                const Divider(color: Colors.grey),
                const SizedBox(height: 5),
              ],
              if (userData.aboutMe != null) ...[
                if (userData.aboutMe!.isEmpty) ...[
                  const SizedBox.shrink()
                ] else ...[
                  AboutMeWidget(user: userData),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.grey),
                ]
              ],
              userData.socialProfileLinks == null
                  ? const SizedBox.shrink()
                  : MySocialMediaWidget(socialProfileLinks: userData.socialProfileLinks!),
              const SizedBox(
                height: 30,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
