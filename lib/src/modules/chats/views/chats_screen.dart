import 'package:flutter/material.dart';
import 'package:yakwetu/src/constants/enums.dart';
import 'package:yakwetu/src/modules/chats/views/components/body.dart';
import 'package:yakwetu/src/widgets/bottom_navigation_bar.dart';

import 'components/chats_app_bar.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatsAppBar(context),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedMenu: MenuState.chats,
      ),
      body: ChatsBody(),
    );
  }
}
