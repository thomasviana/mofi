import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'di/dependency_injection.dart';
import 'firebase_options_uat.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.uat);
  await Firebase.initializeApp(
    name: 'UAT',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
