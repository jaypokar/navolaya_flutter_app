import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/pageIndicatorCubit/page_indicator_page_cubit.dart';

import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../../resources/image_resources.dart';
import '../../../util/common_functions.dart';
import '../../bloc/authBloc/auth_bloc.dart';
import '../../cubit/socketConnectionCubit/socket_connection_cubit.dart';
import 'widget/additional_info_widget.dart';
import 'widget/basic_info_widget.dart';
import 'widget/step_indicator_widget.dart';

class RegistrationPage extends StatefulWidget {
  final String countryCode;
  final String mobileNumber;

  const RegistrationPage({required this.mobileNumber, required this.countryCode, Key? key})
      : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    //_controller.jumpToPage(1);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(listener: (BuildContext blocContext, state) {
          if (state is ProfileErrorState) {
            showMessage(true, state.message);
          } else if (state is UpdateAdditionalInfoState) {
            //showMessage(false, state.updateAdditionalInfo.message!);
            Timer(const Duration(seconds: 2), () {
              Navigator.of(context).pushReplacementNamed(RouteGenerator.dashBoardPage);
            });
          }
        }),
        BlocListener<AuthBloc, AuthState>(listener: (BuildContext blocContext, state) {
          if (state is AuthErrorState) {
            showMessage(true, state.message);
          } else if (state is UpdateBasicInfoState) {
            //showMessage(false, state.loginAndBasicInfoData.message!);
            context.read<SocketConnectionCubit>().init();
            _controller.jumpToPage(1);
          }
        }),
      ],
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                /*image: DecorationImage(
                    image: AssetImage(
                      ImageResources.imgBg,
                    ),
                    fit: BoxFit.cover),*/
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Image.asset(
                  ImageResources.textLogo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.center,
              children: const [
                Center(
                    child: SizedBox(
                        width: 50,
                        child: Divider(
                          color: ColorConstants.greyColor,
                          thickness: 5,
                        ))),
                StepIndicatorWidget(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 7,
              child: PageView(
                onPageChanged: (int page) =>
                    context.read<PageIndicatorPageCubit>().changePage(page),
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  BasicInfoWidget(
                    countryCode: widget.countryCode,
                    mobileNumber: widget.mobileNumber,
                  ),
                  const AdditionalInfoWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showMessage(bool isError, String message) {
    if (mounted) {
      sl<CommonFunctions>().showFlushBar(
        context: context,
        message: message,
        bgColor: isError ? ColorConstants.messageErrorBgColor : ColorConstants.messageBgColor,
      );
    }
  }
}
