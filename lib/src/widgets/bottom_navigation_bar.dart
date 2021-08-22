import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yakwetu/src/constants/constants.dart';
import 'package:yakwetu/src/constants/enums.dart';
import 'package:yakwetu/src/modules/calls/calls_screen.dart';
import 'package:yakwetu/src/modules/chats/views/chats_screen.dart';
import 'package:yakwetu/src/modules/contacts/contacts_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final Color isActiveIconColor = Color(0xFFBBBABA);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 75,
      width: double.infinity,
      // double.infinity means it cove the available width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -7),
            blurRadius: 33,
            color: Color(0xFF6DAED9).withOpacity(0.11),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/contacts.svg",
                color: MenuState.contacts == widget.selectedMenu
                    ? kPrimaryColor
                    : isActiveIconColor,
              ),
              onPressed: () =>
                  // Navigator.pushNamed(context, HomeScreen.routeName),
                  Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ContactsScreen(),
                  transitionDuration: Duration(seconds: 0),
                ),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/chat.svg",
                color: MenuState.chats == widget.selectedMenu
                    ? kPrimaryColor
                    : isActiveIconColor,
              ),
              onPressed: () =>
                  // Navigator.pushNamed(context, MoneyBoxScreen.routeName),
                  Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ChatsScreen(),
                  transitionDuration: Duration(seconds: 0),
                ),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/calls.svg",
                color: MenuState.calls == widget.selectedMenu
                    ? kPrimaryColor
                    : isActiveIconColor,
              ),
              onPressed: () =>
                  // Navigator.pushNamed(context, LimitScreen.routeName),
                  Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => CallsScreen(),
                  transitionDuration: Duration(seconds: 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
