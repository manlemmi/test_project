import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../config/router/app_router.dart';
import '../../../utils/constants/duration.dart';
import '../../../utils/resources/styles.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: kDuration666ms,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    _controller.addListener(() {
      if (_animation.isCompleted) {
        Future.delayed(kDuration222ms, () {
          context.replaceRoute(const ArticlesRoute());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (_, __) {
            return Opacity(
              opacity: _animation.value,
              child: const Text(
                'TEST_PROJECT',
                style: Styles.s35butler,
              ),
            );
          },
        ),
      ),
    );
  }
}
