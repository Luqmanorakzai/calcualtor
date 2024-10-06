import 'package:fluttertoast/fluttertoast.dart';
//access this by the className().method name
class ToastPupop{
  // making it dynamic to pass parameters
  void toastShow(message, bgColor, textColor){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 16.0);
    return;
  }
}