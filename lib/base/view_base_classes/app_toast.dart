import 'package:fluttertoast/fluttertoast.dart';

// import '../../app_routing/app_navigator.dart';
import 'style/style.dart';

// final myAppToast = AppToast._instance();

class AppToast {
  AppToast._instance();
  static AppToast instance = AppToast._instance();

  // // bool _initialized = false;
  // final toast = FToast();

  // void initializeToast() {
  //   toast.init(AppNavigator.key.currentContext);
  //   _initialized = true;
  // }

  void success(title, body) {
    // if (!_initialized) initializeToast();
    // toast.showToast(
    //   gravity: ToastGravity.TOP,
    //   toastDuration: const Duration(seconds: 2),
    //   child: AppToastWidget(
    //     backgroundColor: darkGreenColor,
    //     textColor: textWhiteColor,
    //     title: title,
    //     message: body,
    //   ),
    // );
    Fluttertoast.showToast(
      msg: title == null ? '$body' : '$title\n\n$body',
      backgroundColor: darkGreenColor,
      textColor: textWhiteColor,
      gravity: ToastGravity.TOP,
    );
  }

  void message(title, body) {
    // if (!_initialized) initializeToast();
    // toast.showToast(
    //   gravity: ToastGravity.BOTTOM,
    //   toastDuration: const Duration(seconds: 2),
    //   child: AppToastWidget(
    //     backgroundColor: backgroundBlackColor,
    //     textColor: textWhiteColor,
    //     title: title,
    //     message: body,
    //   ),
    // );
    Fluttertoast.showToast(
      msg: title == null ? '$body' : '$title\n\n$body',
      backgroundColor: backgroundBlackColor,
      textColor: textWhiteColor,
      gravity: ToastGravity.TOP,
    );
  }

  void error(title, body) {
    // if (!_initialized) initializeToast();
    // toast.showToast(
    //   gravity: ToastGravity.TOP,
    //   toastDuration: const Duration(seconds: 2),
    //   child: AppToastWidget(
    //     backgroundColor: textBrownColor,
    //     textColor: textWhiteColor,
    //     title: title,
    //     message: body,
    //   ),
    // );
    Fluttertoast.showToast(
      msg: title == null ? '$body' : '$title\n\n$body',
      backgroundColor: textBrownColor,
      textColor: textWhiteColor,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
