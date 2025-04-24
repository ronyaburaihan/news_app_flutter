import 'package:get/get_instance/src/bindings_interface.dart';

import '../di/injector.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Injector.init();
  }
}