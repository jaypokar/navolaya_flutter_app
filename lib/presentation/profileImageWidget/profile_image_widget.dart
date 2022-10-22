import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navolaya_flutter/features/image_manager.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../core/app_type_def.dart';
import '../../data/sessionManager/session_manager.dart';
import '../../resources/color_constants.dart';
import '../../resources/image_resources.dart';
import '../../resources/value_key_resources.dart';
import '../bloc/profileBloc/profile_bloc.dart';

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
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (_, state) {
                final userImage = sl<SessionManager>().getUserDetails()!.data!.userImage;
                String image = '';
                if (userImage != null) {
                  image = userImage.fileurl!;
                }
                return ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: _croppedFile == null
                      ? image.isEmpty
                          ? Image.asset(ImageResources.cameraIcon, color: Colors.black)
                          : Image.network(
                              image,
                              fit: BoxFit.cover,
                            )
                      : Image.file(File(_croppedFile!.path), fit: BoxFit.cover),
                );
              },
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
    final selection = await showModalBottomSheet(
        constraints: BoxConstraints.loose(
          Size(
            MediaQuery.of(context).size.width,
            170,
          ),
        ),
        isDismissible: true,
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

    if (selection == null) return;

    handleImageSelection(
      () => sl<ImagePicker>().pickImage(
        source: selection == ImageSelectionType.gallery ? ImageSource.gallery : ImageSource.camera,
      ),
    );
  }

  void handleImageSelection(PickImageFromCameraOrGallery pickImageFromCameraOrGallery) async {
    final imageFile = await pickImageFromCameraOrGallery();
    if (imageFile == null) {
      return;
    }

    _croppedFile = await sl<ImageManager>().cropImage(imageFile);

    if (_croppedFile != null) {
      uploadImages(imageFile);
    }
  }

  void uploadImages(XFile? imageXFile) async {
    if (widget.onImageSelected != null) {
      widget.onImageSelected!(_croppedFile);
    }

    final String fileName1 = _croppedFile!.path.split('/').last;
    final imageFile1 = await MultipartFile.fromFile(_croppedFile!.path, filename: fileName1);
    final imageThumbnail = await sl<ImageManager>().getThumbNailImage(_croppedFile!);
    final String fileName2 = imageThumbnail.path.split('/').last;
    final imageFile2 = await MultipartFile.fromFile(imageThumbnail.path, filename: fileName2);

    if (!mounted) return;
    context.read<ProfileBloc>().add(UpdateProfileImageOrAllowNotificationEvent(reqData: {
          ValueKeyResources.uploadProfileImageKey: {
            "user_image": imageFile1,
            "thumb_user_image": imageFile2
          }
        }));
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
          height: 10,
        ),
        ListTile(
          horizontalTitleGap: 10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: Image.asset(
            ImageResources.galleryIcon,
            height: 26,
            width: 26,
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
          horizontalTitleGap: 10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: Image.asset(
            ImageResources.cameraColoredIcon,
            height: 24,
            width: 24,
          ),
          title: const Text(
            StringResources.camera,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.of(context).pop(ImageSelectionType.camera);
          },
        ),
      ],
    );
  }
}
