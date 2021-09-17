import 'package:flutter/material.dart';
import 'package:yakwetu/src/constants/constants.dart';
import 'package:yakwetu/src/modules/chat_inbox/data/chat_message.dart';
import 'package:yakwetu/src/modules/chat_inbox/presentation/components/chat_inbox_bottom_bar.dart';

class ChatInboxBody extends StatefulWidget {
  const ChatInboxBody({Key? key}) : super(key: key);

  @override
  _ChatInboxBodyState createState() => _ChatInboxBodyState();
}

class _ChatInboxBodyState extends State<ChatInboxBody> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Chris, I am doing fine dude. wbu? i miss you",
        messageType: "sender"),
    ChatMessage(messageContent: "eh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: kSecondaryColor,
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType == "receiver"
                              ? Colors.grey
                              : kPrimaryColor),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent!,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        ChatInboxBottomBar()
      ],
    );
  }
}
