import 'package:get/get.dart';
import 'package:demandeautorisation/services/controller/demande_controller.dart';

import '../attached_file_controller.dart';

class DemandeBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<AttachedFileController>(() =>
        AttachedFileController()); // different instances for different pj button

    Get.lazyPut<DemandeController>(
      () => DemandeController(),
      tag: "demandeSingleton",
    );
  }
}