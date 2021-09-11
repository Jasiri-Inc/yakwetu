import 'package:flutter/material.dart';
import 'package:yakwetu/src/config/size_config.dart';
import 'package:yakwetu/src/constants/constants.dart';
import 'package:yakwetu/src/modules/chat_inbox/data/chat_inbox_providers.dart';
import 'package:yakwetu/src/modules/chat_inbox/data/chat_message.dart';

class ChatInboxBottomBar extends StatefulWidget {
  const ChatInboxBottomBar({Key? key}) : super(key: key);

  @override
  _ChatInboxBottomBarState createState() => _ChatInboxBottomBarState();
}

class _ChatInboxBottomBarState extends State<ChatInboxBottomBar> {
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
        vertical: getProportionateScreenHeight(5),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  print('object');
                },
                child: Icon(Icons.add, color: kTextColor)),
            SizedBox(width: getProportionateScreenWidth(10)),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(5) * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                        controller: messageController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(5) / 4),
            GestureDetector(
              onTap: () {
                print(messageController.text);
                _sendMessage(messageController.text);
                messageController.clear();
              },
              child: Icon(
                Icons.send,
                color: kTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    ChatMessage newMessage =
        ChatMessage(messageContent: text, messageType: 'sender');
    messages.add(newMessage);
    print(messages);
  }
}
