import 'package:flutter_test/flutter_test.dart';
import 'package:message_chat/message_chat.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yakwetu/src/modules/chat_inbox/business_logic/message/message_bloc.dart';

import 'message_bloc.mocks.dart';

@GenerateMocks([IMessageService],
    customMocks: [MockSpec<MessageBloc>(returnNullOnMissingStub: true)])
void main() {
  late MessageBloc sut;
  late IMessageService messageService;
  late User user;

  setUp(() {
    messageService = MockIMessageService();
    user = User(
      username: 'test',
      photoUrl: '',
      active: true,
      lastSeen: DateTime.now(),
    );
    sut = MessageBloc(messageService);
  });

  tearDown(() => sut.close());

  test('should emit initial only without subscriptions', () {
    when(sut.state).thenAnswer((realInvocation) => MessageInitial());
    expect(sut.state, MessageInitial());
  });

  test('should emit message sent state when message is sent', () {
    final message = Message(
      from: '123',
      to: '456',
      contents: 'test message',
      timestamp: DateTime.now(),
    );

    when(messageService.send(message)).thenAnswer((_) async => message);
    sut.add(MessageEvent.onMessageSent(message));
    expectLater(sut.stream, emits(MessageState.sent(message)));
  });

  test('should emit messages received from service', () {
    final message = Message(
      from: '123',
      to: '456',
      contents: 'test message',
      timestamp: DateTime.now(),
    );

    when(messageService.messages(activeUser: user))
        .thenAnswer((_) => Stream.fromIterable([message]));

    sut.add(MessageEvent.onSubscribed(user));
    expectLater(sut.stream, emitsInOrder([MessageReceivedSuccess(message)]));
  });
}
