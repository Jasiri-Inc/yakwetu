import 'package:flutter/material.dart';

import 'config/themes/light_theme.dart';
import 'config/themes/theme_config.dart';
import 'modules/chats/presentation/chats_screen.dart';

/// 
/// Commented for testing purposes
/// 

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Food App',
//       theme: theme(),
//       home: ChatsScreen(),
//     );
//   }
// }


class MyApp extends StatelessWidget {
  final Widget firstPage;

  MyApp(this.firstPage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      home: firstPage,
    );
  }
}
