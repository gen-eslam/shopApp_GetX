import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopapp/logic/controller/theme_controller.dart';
import 'package:shopapp/routes/routes.dart';
import 'package:shopapp/utils/my_string.dart';
import 'package:shopapp/utils/theme.dart';

import 'language/localiztion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gen Shop',
      initialRoute: FirebaseAuth.instance.currentUser != null ||
              GetStorage().read<bool>('auth') == true
          ? AppRoutes.mainScreen
          : AppRoutes.welcome,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      fallbackLocale:Locale(ene),
      locale: Locale(GetStorage().read<String>('lang').toString()),
      translations: LocaliztionApp(),
      theme: ThemesApp.light,
      darkTheme: ThemesApp.dark,
      themeMode: ThemeController().themeDataGet,
    );
  }
}
