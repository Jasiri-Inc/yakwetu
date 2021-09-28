import 'package:flutter/foundation.dart' hide Key;
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_chat/message_chat.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yakwetu/src/utils/services/image_upload_service.dart';
import 'package:yakwetu/src/utils/services/local_storage_service.dart';

import 'modules/chat_inbox/business_logic/message/message_bloc.dart';
import 'modules/chat_inbox/business_logic/message_thread/message_thread_cubit.dart';
import 'modules/chat_inbox/business_logic/receipt/receipt_bloc.dart';
import 'modules/chat_inbox/business_logic/typing/typing_bloc.dart';
import 'modules/chat_inbox/data/chat_inbox_providers.dart';
import 'modules/chat_inbox/data/chat_inbox_repository.dart';
import 'modules/chat_inbox/presentation/message_thread/message_thread.dart';
import 'modules/chats/business_logic/chats_cubit.dart';
import 'modules/chats/business_logic/home_cubit.dart';
import 'modules/chats/presentation/home/home.dart';
import 'modules/chats/presentation/home/home_router.dart';
import 'modules/onboarding/onboarding_cubit.dart';
import 'modules/onboarding/presentation/onboarding.dart';
import 'modules/onboarding/presentation/onboarding_router.dart';
import 'modules/onboarding/profile_image_cubit.dart';
import 'package:encrypt/encrypt.dart';


class CompositionRoot {
  static late RethinkDb _r;
  static late Connection _connection;
  static late IUserService _userService;
  static late EncryptionService _encryptionService;
  static late Database _db;
  static late IMessageService _messageService;
  static late IDataSource _datasource;
  static late ILocalCache _localCache;
  static late MessageBloc _messageBloc;
  static late ITypingNotification _typingNotification;
  static late TypingNotificationBloc _typingNotificationBloc;
  static late ChatsCubit _chatsCubit;

  static const kHostAndroid = '10.0.2.2';
  static const kHostIos = '127.0.0.1';

  static configure() async {
    _r = RethinkDb();
    _connection = defaultTargetPlatform == TargetPlatform.iOS ? await _r.connect(host: kHostIos, port: 28015) : await _r.connect(host: kHostAndroid, port: 28015);
    _userService = UserService(_r, _connection);
    _encryptionService = EncryptionService(Encrypter(AES(Key.fromLength(32))));
    _messageService = MessageService(_r, _connection, encryption: _encryptionService);
    _typingNotification = TypingNotification(_r, _connection, _userService);
    _db = await LocalDatabaseFactory().createDatabase();
    _datasource = SqfliteDatasource(_db);
    final sp = await SharedPreferences.getInstance();
    _localCache = LocalCache(sp);
    _messageBloc = MessageBloc(_messageService);
    _typingNotificationBloc = TypingNotificationBloc(_typingNotification);
    final viewModel = ChatsViewModel(_datasource, _userService);
    _chatsCubit = ChatsCubit(viewModel);
    
    // _db.delete('chats');
    // _db.delete('messages');
  }

  static Widget start() {
    final user = _localCache.fetch('USER');
    return user.isEmpty
        ? composeOnboardingUi()
        : composeHomeUi(User.fromJson(user));
  }

  static Widget composeOnboardingUi() {

    String _url = defaultTargetPlatform == TargetPlatform.iOS ? 'http://localhost:3000/upload' : 'http://10.0.2.2:3000/upload';

    ImageUploader imageUploader = ImageUploader(_url);

    OnboardingCubit onboardingCubit =
        OnboardingCubit(_userService, imageUploader, _localCache);
    ProfileImageCubit imageCubit = ProfileImageCubit();
    IOnboardingRouter router = OnboardingRouter(composeHomeUi);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => onboardingCubit),
        BlocProvider(create: (BuildContext context) => imageCubit),
      ],
      child: Onboarding(router),
    );
  }

  static Widget composeHomeUi(User me) {
    HomeCubit homeCubit = HomeCubit(_userService, _localCache);
    IHomeRouter router = HomeRouter(showMessageThread: composeMessageThreadUi);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => homeCubit),
        BlocProvider(
          create: (BuildContext context) => _messageBloc,
        ),
        BlocProvider(create: (BuildContext context) => _typingNotificationBloc),
        BlocProvider(create: (BuildContext context) => _chatsCubit)
      ],
      child: Home(
        me,
        router,
      ),
    );
  }

  static Widget composeMessageThreadUi(User receiver, User me,
      {String? chatId}) {
    ChatViewModel viewModel = ChatViewModel(_datasource);
    MessageThreadCubit messageThreadCubit = MessageThreadCubit(viewModel);
    IReceiptService receiptService = ReceiptService(_r, _connection);
    ReceiptBloc receiptBloc = ReceiptBloc(receiptService);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => messageThreadCubit),
        BlocProvider(create: (BuildContext context) => receiptBloc)
      ],
      child: MessageThread(
        receiver,
        me,
        _messageBloc,
        _chatsCubit,
        _typingNotificationBloc,
        chatId: chatId!,
      ),
    );
  }
}
