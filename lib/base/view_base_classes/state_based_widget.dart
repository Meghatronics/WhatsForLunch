import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utilities/enums.dart';
import 'widgets/app_loading_indicator.dart';

class StateBasedWidget extends StatelessWidget {
  final ViewState state;
  final Widget loadingWidget;
  final Widget errorWidget;
  final Widget noConnectionWidget;
  final Function() retryCallback;
  final Widget preloadWidget;
  final Widget successWidget;
  final bool allowNullState;
  final bool ignoreBuildForError;
  const StateBasedWidget({
    Key key,
    @required this.state,
    this.loadingWidget,
    this.errorWidget,
    this.noConnectionWidget,
    this.retryCallback,
    this.allowNullState = true,
    this.ignoreBuildForError = false,
    this.preloadWidget,
    @required this.successWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state == null && allowNullState) return preloadWidget ?? successWidget;
    switch (state) {
      case ViewState.none:
        return preloadWidget ?? successWidget;
        break;

      case ViewState.done:
        return successWidget;
        break;

      case ViewState.busy:
        return loadingWidget ?? const AppLoadingIndicator();
        break;

      case ViewState.error:
        return ignoreBuildForError
            ? (preloadWidget ?? successWidget)
            : Center(
                child: errorWidget ??
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'An error occured. ',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          children: retryCallback == null
                              ? null
                              : [
                                  TextSpan(
                                    text: 'Retry',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.redAccent,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = retryCallback,
                                  )
                                ],
                        ),
                      ),
                    ),
              );
        break;

      case ViewState.noInternet:
        return ignoreBuildForError
            ? (preloadWidget ?? successWidget)
            : noConnectionWidget ??
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Could not connect. ',
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                    children: retryCallback == null
                        ? null
                        : [
                            TextSpan(
                              text: 'Retry',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = retryCallback,
                            )
                          ],
                  ),
                );
        break;

      default:
        return const SizedBox.shrink();
    }
  }
}
