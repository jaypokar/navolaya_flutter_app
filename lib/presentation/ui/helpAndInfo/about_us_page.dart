import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/cubit/helpAndInfoCubit/help_and_info_cubit.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../resources/color_constants.dart';
import '../../../resources/string_resources.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HelpAndInfoCubit>().fetchAboutUs();

    return BlocListener<HelpAndInfoCubit, HelpAndInfoState>(
      listener: (_, state) {
        if (state is HelpAndInfoErrorState) {
          sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.error,
            bgColor: ColorConstants.messageErrorBgColor,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            StringResources.aboutUs,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<HelpAndInfoCubit, HelpAndInfoState>(
          builder: (_, state) {
            if (state is LoadAboutUsState) {
              return SingleChildScrollView(
                child: Html(
                  data: state.aboutUs,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
