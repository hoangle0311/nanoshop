import 'package:flutter/material.dart';

import '../color_app.dart';
import '../models/data_model.dart';
import '../text_style_chat.dart';
import 'item_list_chat.dart';

Widget BuildListAccount(
    {required List users, required DataModel model, required String id}) {
  print(users.length);
  return users.isNotEmpty
      ? ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: ColorApp.colorBlueF2),
              ),
            ),
            child: ItemListChat(user: users[index], model: model, id: id),
          ),
          itemCount: users.length,
        )
      : Center(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              "Danh sách trống",
              textAlign: TextAlign.center,
              style: TextStyleApp.textStyle600(),
            ),
          ),
        );
}
