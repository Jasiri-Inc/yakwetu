import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'components/body.dart';
import 'components/chat_inbox_app_bar.dart';

// class ChatInboxScreen extends StatelessWidget {
//   const ChatInboxScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: chatInboxAppBar(context), body: ChatInboxBody());
//   }
// }

class ChatInboxScreen extends StatelessWidget {
  const ChatInboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Socket socket = io(
        'http://127.0.0.1:3000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    print(socket.connected);
    print(socket.id);
    socket.onConnect((_) {
      print('connection ipo');
      socket.emit('msg', 'test');
    });

    return Scaffold(appBar: chatInboxAppBar(context), body: ChatInboxBody());
  }
}
