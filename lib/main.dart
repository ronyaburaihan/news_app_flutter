import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:news_app/presentation/pages/home_page.dart';

import 'core/bindings/initial_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Newspaper App',
      initialBinding: InitialBinding(),
      initialRoute: '/',
      getPages: [GetPage(name: '/', page: () => const HomePage())],
    );
  }
}
