import 'package:flutter/material.dart';
import 'package:yakwetu/src/constants/enums.dart';
import 'package:yakwetu/src/widgets/bottom_navigation_bar.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedMenu: MenuState.contacts,
      ),
      body: Center(
        child: Text('contacts'),
      ),
    );
  }
}
