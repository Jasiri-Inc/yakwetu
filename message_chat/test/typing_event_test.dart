import 'package:flutter_test/flutter_test.dart';
import 'package:message_chat/src/models/typing_event.dart';
import 'package:message_chat/src/models/user.dart';
import 'package:message_chat/src/services/typing_event/typing_event_service_impl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rethink_db_ns/rethink_db_ns.dart';

import 'helpers.dart';

void main() {
  RethinkDb r = RethinkDb();
  late Connection connection;
  late TypingNotification sut;

  setUp(() async {
    connection = await r.connect();
    await createDb(r, connection);
    sut = TypingNotification(r, connection, null);
  });

  tearDown(() async {
    sut.dispose();
    await cleanDb(r, connection);
  });

  final user = User.fromJson({
    'id': '1234',
    'active': true,
    'lastSeen': DateTime.now(),
  });

  final user2 = User.fromJson({
    'id': '1111',
    'active': true,
    'lastSeen': DateTime.now(),
  });

  test('sent typing notification successfully', () async {
    TypingEvent typingEvent =
        TypingEvent(from: user2.id, to: user.id, event: Typing.start);

    final res = await sut.send(event: typingEvent);
    expect(res, true);
  });

  test('successfully subscribe and receive typing events', () async {
    sut.subscribe(user2, [user.id!]).listen(expectAsync1((event) {
      expect(event.from, user.id);
    }, count: 2));

    TypingEvent typing = TypingEvent(
      to: user2.id,
      from: user.id,
      event: Typing.start,
    );

    TypingEvent stopTyping = TypingEvent(
      to: user2.id,
      from: user.id,
      event: Typing.stop,
    );

    await sut.send(event: typing);
    await sut.send(event: stopTyping);
  });
}
