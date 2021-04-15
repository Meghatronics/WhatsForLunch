import 'package:flutter/material.dart';

import 'style/style.dart';
import 'widgets/simple_text.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FractionallySizedBox(
            widthFactor: 0.4,
            child: FittedBox(
              child: Icon(
                Icons.wifi,
                color: textWhiteColor,
                size: 64,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: SimpleText(
              'No internet connection',
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
