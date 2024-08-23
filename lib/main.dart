import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigationrail2/config.dart';
import 'package:navigationrail2/repository/material_repository.dart';
import 'package:navigationrail2/repository/ponto_coleta_repository.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'controllers/theme_controller.dart';
import 'pages/home_page.dart';
import 'repository/entidade_repository.dart';

void main() async {
  await initConfigurations();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => PontoColetaRepository(),
      ),
      ChangeNotifierProvider(
        create: (context) => EntidadeRepository(),
      ),
      ChangeNotifierProvider(
        create: (context) => MaterialRepository(),
      ),
    ],
    child: const DescarteBem(),
  ));
}

class DescarteBem extends StatelessWidget {
  const DescarteBem({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController.to.loadThemeMode();

    return GetMaterialApp(
      //MaterialApp(
      title: 'Descarte Bem',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.green,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black26,
          indicatorColor: Colors.white,
        ),
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.green[100],
        ),
      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dividerColor: Colors.black45,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent[100]),
        ),
      ),

      home: AnimatedSplashScreen(
        duration: 2000,
        splashIconSize: 600,
        splash: Image.asset(
          'lib/assets/images/splash400.jpg',
          height: 500,
          width: 500,
          fit: BoxFit.fitWidth,
        ),
        nextScreen: HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.white,
      ),
    );
  }
}
