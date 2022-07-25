import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../injection_container.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../cubit/helpAndInfoCubit/help_and_info_cubit.dart';

class TermsAndConditionPage extends StatelessWidget {
  const TermsAndConditionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HelpAndInfoCubit>().fetchTermAndCondition();

    return BlocListener<HelpAndInfoCubit, HelpAndInfoState>(
      listener: (_, state) {
        if (state is HelpAndInfoErrorState) {
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: state.error,
            bgColor: Colors.red,
            textColor: Colors.white,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            StringResources.termsAndCondition,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<HelpAndInfoCubit, HelpAndInfoState>(
          builder: (_, state) {
            if (state is LoadTermsAndConditionState) {
              return Html(data: state.termAndCondition);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
