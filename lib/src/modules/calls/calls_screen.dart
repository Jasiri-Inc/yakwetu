import 'package:flutter/material.dart';
import 'package:yakwetu/src/constants/enums.dart';
import 'package:yakwetu/src/widgets/bottom_navigation_bar.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedMenu: MenuState.calls,
      ),
      body: Center(
        child: Text('calls'),
      ),
    );
  }
}
