import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sonhador/app/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //MobileAds.instance.initialize();

  await Firebase.initializeApp();
  //runApp(App());
  runApp(ModularApp(
    module: AppModule(),
  ));
}
