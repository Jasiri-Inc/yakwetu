import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ChatMessage extends Equatable {
  ChatMessage({@required this.messageContent, @required this.messageType});

  final String? messageContent;
  final String? messageType;

  List<Object?> get props => [messageContent, messageType];
}
