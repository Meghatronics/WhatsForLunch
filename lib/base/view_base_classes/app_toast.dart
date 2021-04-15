import 'package:fluttertoast/fluttertoast.dart';

import 'style/style.dart';
import 'widgets/app_toast_widget.dart';

class AppToast {
  AppToast._();

  static void success(title, body) {
    FToast().showToast(
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
      child: AppToastWidget(
        backgroundColor: successGreen,
        textColor: textWhite,
        title: title,
        message: body,
      ),
    );
    // Fluttertoast.showToast(
    //   msg: title == null ? '$body' : '$title\n\n$body',
    //   backgroundColor: Colors.greenAccent,
    //   textColor: Colors.black,
    //   gravity: ToastGravity.BOTTOM,
    // );
  }

  static void message(title, body) {
    FToast().showToast(
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
      child: AppToastWidget(
        backgroundColor: backgroundBlack,
        textColor: textWhite,
        title: title,
        message: body,
      ),
    );
    // Fluttertoast.showToast(
    //   msg: title == null ? '$body' : '$title\n\n$body',
    //   backgroundColor: Colors.black87,
    //   textColor: Colors.white,
    //   gravity: ToastGravity.BOTTOM,
    // );
  }

  static void error(title, body) {
    FToast().showToast(
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
      child: AppToastWidget(
        backgroundColor: errorRed,
        textColor: textWhite,
        title: title,
        message: body,
      ),
    );
    // Fluttertoast.showToast(
    //   msg: title == null ? '$body' : '$title\n\n$body',
    //   backgroundColor: Colors.redAccent,
    //   textColor: Colors.white,
    //   gravity: ToastGravity.BOTTOM,
    // );
  }
}
