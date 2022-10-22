import 'dart:math' as math;
import 'dart:math';

import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:navolaya_flutter/data/model/app_contents_model.dart';
import 'package:navolaya_flutter/presentation/basicWidget/no_data_widget.dart';

import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../../resources/image_resources.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../basicWidget/text_field_widget.dart';
import '../../cubit/helpAndInfoCubit/help_and_info_cubit.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({Key? key}) : super(key: key);

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  List<Faqs> faqList = [];
  List<Faqs> tempFaqList = [];
  final _keywordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HelpAndInfoCubit>().fetchFaq();
  }

  @override
  Widget build(BuildContext context) {
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
            StringResources.faq,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextFieldWidget(
                controller: _keywordController,
                hint: StringResources.searchByKeyword,
                textInputType: TextInputType.text,
                onValueChanged: (String query) {
                  final mainQuery = query.toLowerCase();
                  tempFaqList = faqList.where((element) {
                    String title = element.question!.toLowerCase();
                    String ans = element.answer!.toLowerCase();
                    return title.contains(mainQuery) || ans.contains(mainQuery);
                  }).toList();

                  setState(() {});
                },
              ),
            ),
            BlocBuilder<HelpAndInfoCubit, HelpAndInfoState>(
              builder: (_, state) {
                if (state is LoadFaqState) {
                  faqList = state.faqList;

                  if (faqList.isEmpty) {
                    return const Center(
                      child: NoDataWidget(
                        message: StringResources.noDataAvailableMessage,
                        icon: ImageResources.helpInfoIcon,
                        showBackgroundBorder: false,
                      ),
                    );
                  }
                  return Transform.translate(
                    offset: const Offset(0, -20),
                    child: AccordionWidget(
                        key: ValueKey(getRandomString(8)),
                        faq: _keywordController.text.isEmpty ? faqList : tempFaqList),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}

class AccordionWidget extends StatelessWidget {
  final List<Faqs> faq;
  final bool isOpen;

  const AccordionWidget({required this.faq, this.isOpen = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Accordion(
      maxOpenSections: 1,
      children: List<AccordionSection>.generate(
          faq.length,
          (index) => AccordionSection(
                isOpen: false,
                rightIcon: Transform.rotate(
                  angle: 90 * math.pi / 180,
                  child: const Icon(
                    Icons.navigate_next,
                    color: ColorConstants.navigateIconColor,
                    size: 28,
                  ),
                ),
                contentBorderColor: Colors.black,
                headerBackgroundColor: Colors.white,
                headerBackgroundColorOpened: Colors.white,
                contentBackgroundColor: Colors.grey.shade50,
                contentBorderRadius: 20,
                header: Text(
                  faq[index].question!,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                content: SingleChildScrollView(
                  child: Html(data: faq[index].answer!),
                ),
                headerPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                contentHorizontalPadding: 10,
                paddingBetweenClosedSections: 10,
                contentBorderWidth: 0,
              )),
    );
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
    Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
