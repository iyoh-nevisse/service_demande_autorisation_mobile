

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import '../services/controller/demande_controller.dart';
import '../utils/config.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class PdfUploadWidget extends StatefulWidget {
  String title;
  PdfUploadWidget(this.title, { Key? key }) : super(key: key);

  @override
  State<PdfUploadWidget> createState() => _PdfUploadWidgetState();
}

class _PdfUploadWidgetState extends State<PdfUploadWidget> {

  final DemandeController demandeController = Get.find();

  String? fileName ;

  _openFileExplorer() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: [
        'pdf',
      ],
    );

    if(result == null) return;

    // ignore: unrelated_type_equality_checks, invalid_use_of_protected_member
    demandeController.files.value != result.files;
    // ignore: avoid_print
    print('Loaded file path is : ${demandeController.files}');

    final file = result.files.first;
  
    setState(() {
     fileName = file.path;
    });
 

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      fileName != null
        ? Container(
          height: fullHeight(context) * 0.23,
          width: fullWidth(context) * 0.35,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey)
          ),
          child: PdfView(path: fileName!),
         )
        : const SizedBox(),
        ElevatedButton(
          onPressed: _openFileExplorer,
          child: Text(widget.title),
        ),
       if(fileName != null) const Divider()

    ],);
  }

}



