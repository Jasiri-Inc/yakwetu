import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_inbox_events.dart';
part 'chat_inbox_states.dart';

// class ChatInboxMessageBloc
//     extends Bloc<ChatInboxMessageEvent, ChatInboxMessageState> {
//   ChatInboxMessageBloc(ChatInboxMessageState initialState)
//       : super(initialState);

//   @override
//   Stream<ChatInboxMessageState> mapEventToState(ChatInboxMessageEvent event) {
//     // TODO: implement mapEventToState
//     if(event is ChatInboxMessageSent){
//      return _mapChatInboxMessageSentToState(state);
//     }
//   }

//   Stream<ChatInboxMessageState> _mapChatInboxMessageSentToState(ChatInboxMessageState state) {
//     return ChatInboxMessageStatus.ChatInboxMessageSendInProgress.asStream();
//   }
// }

class ChatInboxMessageCubit extends Cubit<ChatInboxMessageState> {
  ChatInboxMessageCubit(initialState) : super(initialState);
}
