import 'package:socket_io_client/socket_io_client.dart';

class SocketConnectionService {
  void createConnection() {
    Socket socket = io(
        'https://yakwetu-backend.herokuapp.com/',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    socket.onConnect((_) {
      print(socket.connected);
      print(socket.id);
      socket.emit('msg', 'test');
      socket.emit('connection', {"socketId": socket.id});
      socket.emit('typing');
      socket.emit('online-status');
    });
  }
}
