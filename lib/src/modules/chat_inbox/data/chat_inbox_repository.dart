import 'package:flutter/foundation.dart';
import 'package:message_chat/message_chat.dart';
import 'package:yakwetu/src/cores/local_storage/models/chart.dart';
import 'package:yakwetu/src/cores/local_storage/models/local_message.dart';

import 'chat_inbox_providers.dart';

abstract class BaseViewModel {
  IDataSource _datasource;

  BaseViewModel(this._datasource);

  @protected
  Future<void> addMessage(LocalMessage message) async {
    if (!await _isExistingChat(message.chatId))
      await _createNewChat(message.chatId);
    await _datasource.addMessage(message);
  }

  Future<bool> _isExistingChat(String chatId) async {
    return await _datasource.findChat(chatId) != null;
  }

  Future<void> _createNewChat(String chatId) async {
    final chat = Chat(chatId);
    await _datasource.addChat(chat);
  }
}

class ChatViewModel extends BaseViewModel {
  IDataSource _datasource;
  String _chatId = '';
  int otherMessages = 0;
  String get chatId => _chatId;

  ChatViewModel(this._datasource) : super(_datasource);

  Future<List<LocalMessage>> getMessages(String chatId) async {
    final messages = await _datasource.findMessages(chatId);
    if (messages.isNotEmpty) _chatId = chatId;
    return messages;
  }

  Future<void> sentMessage(Message message) async {
    LocalMessage localMessage =
        LocalMessage(message.to!, message, ReceiptStatus.sent);
    if (_chatId.isNotEmpty) return await _datasource.addMessage(localMessage);
    _chatId = localMessage.chatId;
    await addMessage(localMessage);
  }

  Future<void> receivedMessage(Message message) async {
    LocalMessage localMessage =
        LocalMessage(message.from!, message, ReceiptStatus.deliverred);
    if (_chatId.isEmpty) _chatId = localMessage.chatId;
    if (localMessage.chatId != _chatId) otherMessages++;
    await addMessage(localMessage);
  }

  Future<void> updateMessageReceipt(Receipt receipt) async {
    await _datasource.updateMessageReceipt(receipt.messageId!, receipt.status!);
  }
}

class ChatsViewModel extends BaseViewModel {
  IDataSource _datasource;
  IUserService _userService;

  ChatsViewModel(this._datasource, this._userService) : super(_datasource);

  Future<List<Chat>> getChats() async {
    final chats = await _datasource.findAllChats();
    await Future.forEach(chats, (chat) async {
      // final user = await _userService.fetch(chat.id);
      // chat!.from = user;
    });

    return chats;
  }

  Future<void> receivedMessage(Message message) async {
    LocalMessage localMessage =
        LocalMessage(message.from!, message, ReceiptStatus.deliverred);
    await addMessage(localMessage);
  }
}
