// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/06/27
// Description:
// -------------------------------------------------------------------
// 在 go_router_helpers.dart
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension GoRouteX on GoRoute {
  static GoRoute custom<T>({
    required String path,
    String? name,
    required Widget Function(BuildContext, GoRouterState) builder,
    Duration duration = const Duration(milliseconds: 350),
    Curve curve = Curves.easeOut,
    Duration? reverseDuration,
  }) {
    final revDur = reverseDuration ?? duration;
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (ctx, state) => CustomTransitionPage<T>(
        key: state.pageKey,
        child: builder(ctx, state),
        transitionDuration: duration,
        reverseTransitionDuration: revDur,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            // horizontal  is left and right push / push
            transitionType: SharedAxisTransitionType.horizontal,

            // transitionType: SharedAxisTransitionType.vertical,
            // fillColor: Colors.transparent,
            child: child,
          );
        },
      ),
    );
  }
}
