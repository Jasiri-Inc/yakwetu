import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_chat/message_chat.dart';
import 'package:yakwetu/src/modules/chat_inbox/business_logic/message/message_bloc.dart';
import 'package:yakwetu/src/modules/chats/business_logic/chats_cubit.dart';
import 'package:yakwetu/src/modules/chats/business_logic/home_cubit.dart';
import 'package:yakwetu/src/modules/chats/business_logic/home_state.dart';
import 'package:yakwetu/src/widgets/active_users.dart';
import 'package:yakwetu/src/widgets/chats.dart';
import 'package:yakwetu/src/widgets/header_status.dart';

import 'home_router.dart';

class Home extends StatefulWidget {
  final User me;
  final IHomeRouter router;
  const Home(this.me, this.router);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  late User _user;
  @override
  void initState() {
    super.initState();
    _user = widget.me;
    _initialSetup();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: HeaderStatus(
            _user.username!,
            _user.photoUrl!,
            true,
            lastSeen: DateTime.now(),
            typing: false,
          ),
          bottom: TabBar(
            indicatorPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            tabs: [
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Messages'),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (_, state) => state is HomeSuccess
                            ? Text('Active(${state.onlineUsers.length})')
                            : Text('Active(0)')),
                  ),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Chats(_user, widget.router),
            ActiveUsers(widget.router, _user),
          ],
        ),
      ),
    );
  }

  _initialSetup() async {
    final user =
        (!_user.active!) ? await context.read<HomeCubit>().connect() : _user;

    context.read<ChatsCubit>().chats();
    context.read<HomeCubit>().activeUsers(user);
    context.read<MessageBloc>().add(MessageEvent.onSubscribed(user));
  }

  @override
  bool get wantKeepAlive => true;
}
