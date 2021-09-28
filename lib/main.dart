import 'package:flutter/material.dart';
import 'package:yakwetu/src/composition_root.dart';


import 'src/app.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();
    final firstPage = CompositionRoot.start();

  runApp(MyApp(firstPage));
}
