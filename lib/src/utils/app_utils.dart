import 'package:chaming/src/widgets/widtoast.dart';

class AppUtils {
  static final AppUtils _instance = new AppUtils.internal();
  static bool networkStatus;

  AppUtils.internal();

  factory AppUtils() {
    return _instance;
  }

  bool isNetworkWorking() {
    return networkStatus;
  }

  void showAlert(String msg) {
    FlutterToast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      textcolor: '#ffffff'
    );
  }

}
