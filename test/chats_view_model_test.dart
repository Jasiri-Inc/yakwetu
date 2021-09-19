import 'package:flutter_test/flutter_test.dart';
import 'package:message_chat/message_chat.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yakwetu/src/cores/local_storage/models/chart.dart';
import 'package:yakwetu/src/modules/chat_inbox/data/chat_inbox_providers.dart';
import 'package:yakwetu/src/modules/chat_inbox/data/chat_inbox_repository.dart';

import 'chats_view_model_test.mocks.dart';

@GenerateMocks([IDataSource, IUserService])
void main() {
  late ChatsViewModel sut;
  late MockIDataSource mockDatasource;
  late MockIUserService mockUserService;

  setUp(() {
    mockDatasource = MockIDataSource();
    mockUserService = MockIUserService();
    sut = ChatsViewModel(mockDatasource, mockUserService);
  });

  final message = Message.fromJson({
    'from': '111',
    'to': '222',
    'contents': 'hey',
    'timestamp': DateTime.parse("2021-04-01"),
    'id': '4444'
  });

  test('initial chats return empty list', () async {
    when(mockDatasource.findAllChats()).thenAnswer((_) async => []);
    expect(await sut.getChats(), isEmpty);
  });

  test('returns list of chats', () async {
    final chat = Chat('123');
    when(mockDatasource.findAllChats()).thenAnswer((_) async => [chat]);
    final chats = await sut.getChats();
    expect(chats, isNotEmpty);
  });

  test('creates a new chat when receiving message for the first time',
      () async {
    when(mockDatasource.findChat(any)).thenAnswer((_) async => null);
    await sut.receivedMessage(message);
    verify(mockDatasource.addChat(any)).called(1);
  });

  test('add new message to existing chat', () async {
    final chat = Chat('123');

    when(mockDatasource.findChat(any)).thenAnswer((_) async => chat);
    await sut.receivedMessage(message);
    verifyNever(mockDatasource.addChat(any));
    verify(mockDatasource.addMessage(any)).called(1);
  });
}
