import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'di/dependency_injection.dart';
import 'firebase_options_dev.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.dev);
  await Firebase.initializeApp(
    name: 'DEV',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
