import 'package:bloc/bloc.dart';
import 'package:yakwetu/src/cores/local_storage/models/local_message.dart';
import 'package:yakwetu/src/modules/chat_inbox/data/chat_inbox_repository.dart';

class MessageThreadCubit extends Cubit<List<LocalMessage>> {
  final ChatViewModel viewModel;
  MessageThreadCubit(this.viewModel) : super([]);

  Future<void> messages(String chatId) async {
    final messages = await viewModel.getMessages(chatId);
    emit(messages);
  }
}
