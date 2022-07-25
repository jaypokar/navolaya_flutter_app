import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../cubit/helpAndInfoCubit/help_and_info_cubit.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HelpAndInfoCubit>().fetchFaq();

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
            StringResources.faq,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<HelpAndInfoCubit, HelpAndInfoState>(
          builder: (_, state) {
            if (state is LoadFaqState) {
              return Accordion(
                maxOpenSections: 1,
                children: List<AccordionSection>.generate(
                    state.faqList.length,
                    (index) => AccordionSection(
                          isOpen: index == 0,
                          rightIcon: const Icon(Icons.arrow_drop_down),
                          headerBackgroundColor: Colors.white,
                          headerBackgroundColorOpened: Colors.white70,
                          header: Text(
                            state.faqList[index].question!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          content: Text(
                            state.faqList[index].answer!,
                          ),
                          contentHorizontalPadding: 10,
                          paddingBetweenClosedSections: 10,
                          contentBorderWidth: 0,
                        )),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
