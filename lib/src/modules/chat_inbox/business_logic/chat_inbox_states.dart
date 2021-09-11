part of 'chat_inbox_cubit.dart';

enum ChatInboxMessageStatus {
  ChatInboxMessageInitial,
  ChatInboxMessageSendInProgress,
  ChatInboxMessageSendSuccess,
  ChatInboxMessageSendDelivered,
  ChatInboxMessageSendRead,
  ChatInboxMessageSendError
}

class ChatInboxMessageState extends Equatable {
  ChatInboxMessageState(this.messageId, this.message, this.senderId);

  final String messageId;
  final String message;
  final String senderId;

  @override
  // TODO: implement props
  List<Object?> get props => [messageId, message, senderId];
}
