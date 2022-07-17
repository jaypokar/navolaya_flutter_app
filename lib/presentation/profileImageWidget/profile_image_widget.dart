import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/basicWidget/custom_button.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../core/color_constants.dart';
import '../../resources/image_resources.dart';

typedef _PickImageFromCameraOrGallery = Future<XFile?> Function();

enum ImageSelectionType { gallery, camera, cancel }

class ProfileImageWidget extends StatefulWidget {
  final Function? onImageSelected;

  const ProfileImageWidget({this.onImageSelected, Key? key}) : super(key: key);

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 116,
      width: 116,
      child: Stack(
        children: [
          Container(
            height: 114,
            width: 114,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstants.inputBorderColor,
              ),
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: _croppedFile == null
                  ? Image.asset(ImageResources.cameraIcon, color: Colors.black)
                  : Image.file(File(_croppedFile!.path), fit: BoxFit.cover),
            ),
          ),
          Positioned(
              bottom: 4,
              right: 8,
              child: SizedBox(
                height: 28,
                width: 28,
                child: RawMaterialButton(
                  onPressed: () {
                    callBottomSheet();
                  },
                  elevation: 2.0,
                  fillColor: Colors.red,
                  padding: const EdgeInsets.all(0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void callBottomSheet() async {
    ImageSelectionType selection = await showModalBottomSheet(
        constraints: BoxConstraints.loose(
          Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.33,
          ),
        ),
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (_) {
          return const ImageSelectionWidget();
        });

    if (selection == ImageSelectionType.gallery) {
      handleImageSelection(() => sl<ImagePicker>().pickImage(source: ImageSource.gallery));
    } else if (selection == ImageSelectionType.camera) {
      handleImageSelection(() => sl<ImagePicker>().pickImage(source: ImageSource.camera));
    }
  }

  void handleImageSelection(_PickImageFromCameraOrGallery pickImageFromCameraOrGallery) async {
    final imageFile = await pickImageFromCameraOrGallery();
    if (imageFile == null) {
      return;
    }

    _croppedFile = await sl<ImageCropper>().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 2, ratioY: 3),
      maxWidth: 400,
      maxHeight: 600,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: ColorConstants.appColor,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: true,
          minimumAspectRatio: 2 * 3,
        ),
      ],
    );

    if (_croppedFile != null) {
      final bytes = await _croppedFile!.readAsBytes();
      logger
          .i('the image size is :${sl<CommonFunctions>().getFileSizeString(bytes: bytes.length)}');
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(_croppedFile);
      }
    }

    setState(() {});
  }
}

class ImageSelectionWidget extends StatelessWidget {
  const ImageSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        ListTile(
          horizontalTitleGap: 20,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: Image.asset(
            ImageResources.galleryIcon,
            height: 34,
            width: 34,
          ),
          title: const Text(
            StringResources.gallery,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.of(context).pop(ImageSelectionType.gallery);
          },
        ),
        const Divider(),
        ListTile(
          horizontalTitleGap: 20,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: Image.asset(
            ImageResources.cameraColoredIcon,
            height: 34,
            width: 34,
          ),
          title: const Text(
            StringResources.camera,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.of(context).pop(ImageSelectionType.camera);
          },
        ),
        const Divider(),
        ButtonWidget(
            buttonText: StringResources.cancel,
            padding: 20,
            onPressButton: () => Navigator.of(context).pop(ImageSelectionType.cancel))
      ],
    );
  }
}
