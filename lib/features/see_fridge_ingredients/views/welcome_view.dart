import 'package:flutter/material.dart';

import '../../../app_routing/app_navigator.dart';
import '../../../base/view_base_classes/style/style.dart';
import '../../../base/view_base_classes/widgets/custom_dot_widget.dart';
import '../../../base/view_base_classes/widgets/simple_text.dart';
import '../widgets/welcome_view_background_painter.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGreenColor,
      body: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: WelcomeViewBackgroundPainter(),
        child: Container(
          alignment: const Alignment(-1, -0.25),
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SimpleText(
                'What shall the\nson of man',
                size: 32,
                weight: FontWeight.w500,
                color: textWhiteColor,
              ),
              // const SizedBox(height: 4),
              TweenAnimationBuilder<double>(
                duration: const Duration(seconds: 3),
                curve: Curves.bounceOut,
                tween: Tween<double>(
                  begin: MediaQuery.of(context).size.width - 240,
                  end: 16,
                ),
                builder: (_, space, child) => Row(
                  children: [
                    child,
                    SizedBox(width: space),
                    const CustomDot(size: 24),
                  ],
                ),
                child: const SimpleText(
                  'Eat?',
                  size: 48,
                  weight: FontWeight.w700,
                  color: lightGreenColor,
                ),
                onEnd: () {
                  AppNavigator.pushNamedAndClear(fridgeViewRoute);
                },
              ),
              Divider(endIndent: MediaQuery.of(context).size.width - 210),
            ],
          ),
        ),
      ),
    );
  }
}
