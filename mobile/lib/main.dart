import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:simple/module/login/login_page.dart';
import 'package:simple/utils/database.dart';
import 'package:simple/utils/locator.dart';
import 'package:theme_provider/theme_provider.dart';

import 'themes/dark.dart';
import 'themes/light.dart';

void main() {
  setupLocator();
  setupDatabase();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      themes: [
        darkTheme,
        lightTheme,
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => GetMaterialApp(
            theme: ThemeProvider.themeOf(themeContext).data,
            home: LoginPage(),
            builder: EasyLoading.init(),
          ),
        ),
      ),
    );
  }
}
