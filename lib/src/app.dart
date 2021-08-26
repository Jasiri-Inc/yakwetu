import 'package:flutter/material.dart';

import 'config/themes/theme_config.dart';
import 'modules/chats/views/chats_screen.dart';

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
