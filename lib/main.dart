import 'package:flutter/material.dart';
import 'package:yakwetu/src/utils/services/socket_connection_service.dart';

import 'src/app.dart';

void main() {

  SocketConnectionService newSocket = SocketConnectionService();
  newSocket.createConnection();

  runApp(MyApp());

}
