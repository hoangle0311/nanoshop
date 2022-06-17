import 'package:intl/intl.dart';

import 'Enum.dart';

class ConstChat{
  static formatDate(String time, TypeTime type) {
    var check = ConstChat.isNumeric(time);
    if(check){
      if(type == TypeTime.milliseconds){
        return DateFormat('dd-MM-yyyy', 'en_US')
            .format(DateTime.fromMillisecondsSinceEpoch(int.parse(time)));
      }else if(type == TypeTime.seconds){
        return DateFormat('dd-MM-yyyy', 'en_US')
            .format(DateTime.fromMillisecondsSinceEpoch(int.parse(time) * 1000));
      }else if(type == TypeTime.milliseconds){
        return DateFormat('dd-MM-yyyy', 'en_US')
            .format(DateTime.fromMicrosecondsSinceEpoch(int.parse(time) * 1000000));
      }
    }else{
      return "";
    }
  }

  static formatTime(String time, TypeTime type) {
    var check = ConstChat.isNumeric(time);
    if(check){
      if(type == TypeTime.milliseconds){
        return DateFormat.Hm()
            .format(DateTime.fromMillisecondsSinceEpoch(int.parse(time)));
      }else if(type == TypeTime.seconds){
        return DateFormat.Hm()
            .format(DateTime.fromMillisecondsSinceEpoch(int.parse(time) * 1000));
      }else if(type == TypeTime.milliseconds){
        return DateFormat.Hm()
            .format(DateTime.fromMicrosecondsSinceEpoch(int.parse(time) * 1000000));
      }
    }else{
      return "";
    }
  }

  static bool isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  static String convertTypeMessage({int? typeMessage, String content = ""}) {

    if(typeMessage == MessageType.text.index){
      return content;
    }else if(typeMessage == MessageType.image.index){
      return 'Đã gửi một hình ảnh';
    }else if(typeMessage == MessageType.video.index){
      return 'Đã gửi một Video';
    }else if(typeMessage == MessageType.doc.index){
      return 'Đã gửi một Tài liệu';
    }else if(typeMessage == MessageType.location.index){
      return 'Đã gửi vị trí';
    }else if(typeMessage == MessageType.contact.index){
      return 'Đã gửi một liên hệ';
    }else if(typeMessage == MessageType.audio.index){
      return 'Đã gửi một audio';
    }else if(typeMessage == MessageType.audio.index){
      return 'Đã gửi một audio';
    }else if(typeMessage == MessageType.title.index){
      return 'Đã gửi một tiêu đề';
    }else{
      return "";
    }
  }
}