import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/ui/updateJNVVerification/widgets/view_pdf_page.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';

import '../../../resources/image_resources.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../basicWidget/custom_button.dart';
import '../../basicWidget/loading_widget.dart';

class UpdateJNVVerificationPage extends StatefulWidget {
  const UpdateJNVVerificationPage({Key? key}) : super(key: key);

  @override
  State<UpdateJNVVerificationPage> createState() => _UpdateJNVVerificationPageState();
}

class _UpdateJNVVerificationPageState extends State<UpdateJNVVerificationPage> {
  final _fileNotifier = ValueNotifier<PlatformFile?>(null);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (_, state) async {
        if (state is ProfileErrorState) {
          sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.message,
            bgColor: ColorConstants.messageErrorBgColor,
          );
        } else if (state is UpdateJNVVerificationState) {
          await sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.response.message!,
            duration: 2,
          );
          if (!mounted) return;
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            StringResources.jnvVerification,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 53,
                ),
                const Text(
                  StringResources.uploadJNVDocument,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 23, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  StringResources.uploadJNVDocumentSubTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: ColorConstants.textColor1),
                ),
                const SizedBox(
                  height: 30,
                ),
                DottedBorder(
                  color: ColorConstants.dottedLineColor,
                  strokeWidth: 1,
                  child: InkWell(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                      if (result != null) {
                        _fileNotifier.value = result.files.first;
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 193,
                      child: ValueListenableBuilder<PlatformFile?>(
                        valueListenable: _fileNotifier,
                        builder: (_, file, __) {
                          if (file != null) {
                            return ViewPdfPage(file: file);
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageResources.addDocumentIcon,
                                height: 44,
                                width: 44,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                StringResources.chooseFileHere,
                                style: TextStyle(fontSize: 11, color: ColorConstants.textColor1),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                getButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (_, state) {
      if (state is ProfileLoadingState) {
        return const LoadingWidget();
      } else {
        return ButtonWidget(
          buttonText: StringResources.submit.toUpperCase(),
          padding: 0,
          onPressButton: () async {
            if (_fileNotifier.value != null) {
              final String fileName = _fileNotifier.value!.path!.split('/').last;
              final file =
                  await MultipartFile.fromFile(_fileNotifier.value!.path!, filename: fileName);
              if (!mounted) return;
              context.read<ProfileBloc>().add(UpdateJNVVerificationEvent(reqData: {
                    "verification_doc": file,
                  }));
            }
          },
        );
      }
    });
  }
}
