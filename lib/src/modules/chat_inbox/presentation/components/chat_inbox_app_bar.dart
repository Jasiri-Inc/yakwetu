import 'package:flutter/material.dart';

AppBar chatInboxAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    flexibleSpace: SafeArea(
      child: Container(
        padding: EdgeInsets.only(right: 16),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 2,
            ),
            CircleAvatar(
              backgroundImage:
                  NetworkImage("https://randomuser.me/api/portraits/men/5.jpg"),
              maxRadius: 20,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Francis TAll",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "online",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.call,
              color: Colors.black,
            ),
          ],
        ),
      ),
    ),
  );
}
