import 'package:shared_preferences/shared_preferences.dart';

import 'data_model.dart';

class ModelChatScreen{
  String name;
  String currentUserNo,peerNo;
  DataModel? model;
  SharedPreferences? prefs;
  int count;
  ModelChatScreen({required this.name,required this.currentUserNo,required this.peerNo, this.model, this.prefs, this.count = 0});
}
