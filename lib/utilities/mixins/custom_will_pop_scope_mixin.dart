import '../../base/view_base_classes/app_toast.dart';
import '../constants/constants.dart';

mixin CustomWillPopScopeMixin {
  static bool _secondBack = false;
  static const secondTapDurationSpace = Duration(seconds: 2);
  Future<bool> onSecondBackPop() async {
    if (!_secondBack) {
      AppToast.message(null, 'Press back again to close $appName');
      _secondBack = true;
      Future.delayed(secondTapDurationSpace, () => _secondBack = false);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> delayAndPop() async {
    AppToast.message(null, 'Closing $appName');
    return Future.delayed(secondTapDurationSpace, () => true);
  }
}
