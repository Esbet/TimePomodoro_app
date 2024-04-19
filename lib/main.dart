import 'package:flutter/material.dart';

import 'injection_container.dart';
import 'maincommon.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await injectDependencies();

  runApp(const MyApp());
}