import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/constants.dart';

AppBar chatsAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "Chats",
            style: TextStyle(color: kSecondaryColor),
          ),
          TextSpan(
            text: "Pay",
            style: TextStyle(color: kPrimaryColor),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset(
          "assets/icons/plus.svg",
          height: 35,
          width: 18,
        ),
        onPressed: () {},
      ),
    ],
  );
}
