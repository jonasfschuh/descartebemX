import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/theme_controller.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

initConfigurations() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Initialized default app $app');
  auth = FirebaseAuth.instanceFor(app: app);

  // Para executar o Firebase no Emulador Local do Firebase descomentar a seguir
  // FirebaseFirestore.instance.settings =
  //   Settings(host: 'localhost:8080', sslEnabled: false);

  // GetX Bindings
  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.put(AuthService());
}
