import 'package:bloc/bloc.dart';
import 'package:yakwetu/src/cores/local_storage/models/chart.dart';
import 'package:yakwetu/src/modules/chat_inbox/data/chat_inbox_repository.dart';

class ChatsCubit extends Cubit<List<Chat>> {
  final ChatsViewModel viewModel;
  ChatsCubit(this.viewModel) : super([]);

  Future<void> chats() async {
    final chats = await viewModel.getChats();
    emit(chats);
  }
}
