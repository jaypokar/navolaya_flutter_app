import 'dart:io' as IO;
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as image_lib;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../resources/color_constants.dart';

class DecodeParam {
  final IO.File file;
  final SendPort sendPort;

  DecodeParam(this.file, this.sendPort);
}

void decodeIsolate(DecodeParam param) {
  // Read an image from file (webp in this case).
  // decodeImage will identify the format of the image and use the appropriate
  // decoder.
  var image = image_lib.decodeImage(param.file.readAsBytesSync())!;
  // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
  var thumbnail = image_lib.copyResize(image, height: 250, width: 200);
  param.sendPort.send(thumbnail);
}

class ImageManager {
  final ImageCropper _imageCropper;

  ImageManager(this._imageCropper);

  Future<CroppedFile?> cropImage(XFile? imageFile) async {
    return await _imageCropper.cropImage(
      sourcePath: imageFile!.path,
      aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 5),
      maxWidth: 1000,
      maxHeight: 1250,
      compressQuality: 95,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: ColorConstants.appColor,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: true,
          minimumAspectRatio: 4 * 5,
        ),
      ],
    );
  }

  Future<IO.File> getThumbNailImage(CroppedFile croppedFile) async {
    final String fileName1 = croppedFile.path.split('/').last;
    var receivePort = ReceivePort();

    await Isolate.spawn(
        decodeIsolate, DecodeParam(IO.File(croppedFile.path), receivePort.sendPort));

    // Get the processed image from the isolate.
    var image = await receivePort.first as image_lib.Image;

    // Save the thumbnail as a PNG.
    final path = IO.Platform.isIOS
        ? (await getApplicationDocumentsDirectory()).path
        : (await getExternalStorageDirectory())!.path;
    final imageThumbnail = IO.File('$path/thumbnail$fileName1')
      ..writeAsBytesSync(image_lib.encodePng(image));
    return imageThumbnail;
  }
}
