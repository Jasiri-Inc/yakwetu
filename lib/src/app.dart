import 'package:flutter/material.dart';
import 'package:yakwetu/src/modules/chats/chats_screen.dart';

import 'config/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: theme(),
      home: ChatsScreen(),
    );
  }
}
