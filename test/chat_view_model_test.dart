import 'package:flutter_test/flutter_test.dart';
import 'package:message_chat/message_chat.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yakwetu/src/cores/local_storage/models/chart.dart';
import 'package:yakwetu/src/cores/local_storage/models/local_message.dart';
import 'package:yakwetu/src/modules/chat_inbox/data/chat_inbox_repository.dart';

import './chat_view_model_test.mocks.dart';
import '../lib/src/modules/chat_inbox/data/chat_inbox_providers.dart';

@GenerateMocks([IDataSource])
void main() {
  late ChatViewModel sut;
  late MockIDataSource mockDatasource;

  setUp(() {
    mockDatasource = MockIDataSource();
    sut = ChatViewModel(mockDatasource);
  });

  final message = Message.fromJson({
    'from': '111',
    'to': '222',
    'contents': 'hey',
    'timestamp': DateTime.parse("2021-04-01"),
    'id': '4444'
  });

  test('initial messages return empty list', () async {
    when(mockDatasource.findMessages(any)).thenAnswer((_) async => []);
    expect(await sut.getMessages('123'), isEmpty);
  });

  test('returns list of messages from local storage', () async {
    final chat = Chat('123');
    final localMessage =
        LocalMessage(chat.id, message, ReceiptStatus.deliverred);
    when(mockDatasource.findMessages(chat.id))
        .thenAnswer((_) async => [localMessage]);
    final messages = await sut.getMessages('123');
    expect(messages, isNotEmpty);
    expect(messages.first.chatId, '123');
  });

  test('creates a new chat when sending first message', () async {
    when(mockDatasource.findChat(any)).thenAnswer((_) async => null);
    await sut.sentMessage(message);
    verify(mockDatasource.addChat(any)).called(1);
  });

  test('add new sent message to the chat', () async {
    final chat = Chat('123');
    final localMessage = LocalMessage(chat.id, message, ReceiptStatus.sent);
    when(mockDatasource.findMessages(chat.id))
        .thenAnswer((_) async => [localMessage]);

    await sut.getMessages(chat.id);
    await sut.sentMessage(message);

    verifyNever(mockDatasource.addChat(any));
    verify(mockDatasource.addMessage(any)).called(1);
  });

  test('add new received message to the chat', () async {
    final chat = Chat('111');
    final localMessage =
        LocalMessage(chat.id, message, ReceiptStatus.deliverred);
    when(mockDatasource.findMessages(chat.id))
        .thenAnswer((_) async => [localMessage]);
    when(mockDatasource.findChat(chat.id)).thenAnswer((_) async => chat);

    await sut.getMessages(chat.id);
    await sut.receivedMessage(message);

    verifyNever(mockDatasource.addChat(any));
    verify(mockDatasource.addMessage(any)).called(1);
  });

  test('creates new chat when message received is not apart of this chat',
      () async {
    final chat = Chat('123');
    final localMessage =
        LocalMessage(chat.id, message, ReceiptStatus.deliverred);
    when(mockDatasource.findMessages(chat.id))
        .thenAnswer((_) async => [localMessage]);
    when(mockDatasource.findChat(chat.id)).thenAnswer((_) async => null);

    await sut.getMessages(chat.id);
    await sut.receivedMessage(message);

    verify(mockDatasource.addChat(any)).called(1);
    verify(mockDatasource.addMessage(any)).called(1);
    expect(sut.otherMessages, 1);
  });
}
