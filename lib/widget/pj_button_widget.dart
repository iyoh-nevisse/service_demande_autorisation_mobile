// ignore_for_file: avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demandeautorisation/services/controller/attached_file_controller.dart';

import '../services/controller/demande_controller.dart';

class PjButtonWidget extends StatefulWidget {
  final DemandeController demandeController =
      Get.find<DemandeController>(tag: 'demandeSingleton');
  final AttachedFileController attachedFileController =
      Get.find<AttachedFileController>();
  PjButtonWidget({Key? key}) : super(key: key);
  @override
  State<PjButtonWidget> createState() => _PjButtonWidgetState();
}

class _PjButtonWidgetState extends State<PjButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print(
            'attached file list befor ::::: ${widget.demandeController.files}');

        _openFileExplorer();
        print(
            'attached file list after ::::: ${widget.demandeController.files}');
      },
      child: Obx(() => Text(
            widget.attachedFileController.pj.value.name,
          )),
    );
  }

  void _openFileExplorer() async {
    widget.demandeController.files
        .remove(widget.attachedFileController.pj.value.name);
    widget.attachedFileController.pj.value =
        (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: [
        'pdf',
      ],
    ))!
            .files
            .first;
    widget.demandeController
            .files[widget.attachedFileController.pj.value.name] =
        widget.attachedFileController.pj.value;

    print('Loaded file path is : ${widget.demandeController.files}');
  }
}
