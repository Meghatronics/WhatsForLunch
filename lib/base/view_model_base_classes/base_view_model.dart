import 'package:flutter/cupertino.dart';

import '../../utilities/constants/constants.dart';
import '../../utilities/enums.dart';
import '../data_base_classes/failures.dart';
import '../view_base_classes/app_toast.dart';

export '../../utilities/enums.dart';

class BaseViewModel extends ChangeNotifier {
  BaseViewModel() {
    initialize();
  }
  ViewState viewState;
  String viewMessage;
  bool _disposed = false;

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  void initialize() {
    //
  }

  void setState({ViewState viewState, String viewMessage}) {
    if (viewState != null) this.viewState = viewState;
    if (viewMessage != null) this.viewMessage = viewMessage;
    if (!_disposed) notifyListeners();
  }

  void handleFailure(Failure failure, {String title}) {
    switch (failure.runtimeType) {
      case InputFailure:
        AppToast.instance.error(
          title,
          (failure as InputFailure).errorMessage,
        );
        break;

      case ServerFailure:
        AppToast.instance.error(
          title ?? 'A problem occured',
          (failure as ServerFailure).error ?? serverErrorMessage,
        );
        break;
      case BadAuthFailure:
        AppToast.instance.error(
          title ?? 'A problem occured',
          (failure as BadAuthFailure).errorMessage ?? serverErrorMessage,
        );
        break;

      case NetworkFailure:
        AppToast.instance.error(
          "Couldn't connect",
          networkErrorMessage,
        );
        setState(viewState: ViewState.noInternet);
        // AppNavigator.push(const NoInternetView());
        break;

      default:
        AppToast.instance.error(title, 'Unknown error. Try again later.');
    }
    if (failure.runtimeType != NetworkFailure)
      setState(viewState: ViewState.error);
  }
}
