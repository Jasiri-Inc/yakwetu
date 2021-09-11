part of 'chat_inbox_cubit.dart';

abstract class ChatInboxMessageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatInboxMessageSent extends ChatInboxMessageEvent {}
