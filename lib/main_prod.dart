import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mofi/app.dart';
import 'package:mofi/di/dependency_injection.dart';

import 'firebase_options_prod.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  await Firebase.initializeApp(
    name: 'PROD',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
