import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_inbox_events.dart';
part 'chat_inbox_states.dart';

class ChatInboxMessageCubit extends Cubit<ChatInboxMessageState> {
  ChatInboxMessageCubit(initialState) : super(initialState);
}
