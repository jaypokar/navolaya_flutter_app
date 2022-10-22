import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPdfPage extends StatefulWidget {
  final PlatformFile file;

  const ViewPdfPage({required this.file, Key? key}) : super(key: key);

  @override
  State<ViewPdfPage> createState() => _ViewPdfPageState();
}

class _ViewPdfPageState extends State<ViewPdfPage> {
  String fileName = '';
  final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();
    _pdfViewerController.addListener(({property}) {
      if (_pdfViewerController.scrollOffset == Offset.zero) {
        print("Count ${_pdfViewerController.pageCount}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SfPdfViewer.file(
        File(widget.file.path!),
        controller: _pdfViewerController,
        pageLayoutMode: PdfPageLayoutMode.single,
      ),
    );
  }
}
