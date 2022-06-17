import 'package:nanoshop/src/chat/utils/utils.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../domain/entities/user_login/user_login.dart';
import 'firebase/firebase_account.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


import 'config/Dbkeys.dart';
import 'item/build_list_account.dart';
import 'models/data_model.dart';

class ListChat extends StatefulWidget {
  String id;
  ListChat({required this.id});
  @override
  State<ListChat> createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> with WidgetsBindingObserver {
  bool showHidden = false;
  getModel() {
    DataModel dataModel = DataModel(widget.id);
    return dataModel;
  }
  List<Map<String, dynamic>> _users = List.from(<Map<String, dynamic>>[]);

  buildListAcount({required DataModel model}) {
    Map<String?, Map<String, dynamic>?> _userData = model.userData;
    _users = Map.from(_userData)
        .values
        .where((_user) => _user.keys.contains(Dbkeys.chatStatus))
        .toList()
        .cast<Map<String, dynamic>>();
    if (!showHidden) {
      _users.removeWhere((_user) => _isHidden(_user[Dbkeys.id],model));
    }
    return BuildListAccount(users: _users,model: model, id: widget.id);
  }

  _isHidden(id, DataModel model) {
    Map<String, dynamic> _currentUser = model.currentUser!;
    return _currentUser[Dbkeys.hidden] != null &&
        _currentUser[Dbkeys.hidden].contains(id);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
      setOnline();
    else
      setOffline();
  }

  void setOffline() async {
   await FireBaseAccount.updateUser({"status": false}, injector<UserLogin>());
  }

  void setOnline() async {
    await FireBaseAccount.updateUser({"status": true}, injector<UserLogin>());
  }
  @override
  void initState() {
    super.initState();
    setOnline();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: "Tin nhắn",
      ),
      body: Fiberchat.getNTPWrappedWidget(
        child: RefreshIndicator(
          onRefresh: () {
            setState(() {
              showHidden = true;
            });
            return Future.value(false);
          },
          child: ScopedModel<DataModel>(
            model: getModel(),
            child: ScopedModelDescendant<DataModel>(
              builder: (context, child, _model) {
                return buildListAcount(model: _model);
              },
            ),
          ),
        ),
      ),
    );
  }
}
