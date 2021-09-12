import 'package:message_chat/src/models/message.dart';
import 'package:message_chat/src/models/user.dart';
import 'package:flutter/foundation.dart';

abstract class IMessageService {
  Future<Message> send(Message message);
  Stream<Message> messages({@required User activeUser});
  dispose();
}
