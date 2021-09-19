import 'package:message_chat/message_chat.dart';

import './local_message.dart';

class Chat {
  String id;
  int unread = 0;
  List<LocalMessage>? messages = [];
  LocalMessage? mostRecent;
  late User from;
  Chat(this.id, {this.messages, this.mostRecent});

  toMap() => {'id': id};
  factory Chat.fromMap(Map<String, dynamic> json) => Chat(json['id']);
}
