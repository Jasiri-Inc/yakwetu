import 'package:flutter/material.dart';

import 'components/chats_app_bar.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatsAppBar(context),
    );
  }
}
