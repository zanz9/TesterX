import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:testerx/pages/index.dart';

enum RouterNames { home, test, settings }

final router = GoRouter(
  routes: [
    GoRoute(
      name: RouterNames.home.name,
      path: '/',
      builder: (context, state) => const Home(),
      pageBuilder: defaultPageBuilder(const Home(), FromWhere.left),
    ),
    GoRoute(
      name: RouterNames.test.name,
      path: '/test',
      builder: (context, state) => const TestPage(),
      pageBuilder: defaultPageBuilder(const TestPage(), FromWhere.bottom),
    ),
    GoRoute(
      name: RouterNames.settings.name,
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
      pageBuilder: defaultPageBuilder(const SettingsPage(), FromWhere.right),
    ),
  ],
);

enum FromWhere { left, right, top, bottom }

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required FromWhere from,
}) {
  Offset offset;
  switch (from) {
    case FromWhere.left:
      offset = const Offset(-1, 0);
      break;
    case FromWhere.right:
      offset = const Offset(1, 0);
      break;
    case FromWhere.top:
      offset = const Offset(0, -1);
      break;
    case FromWhere.bottom:
      offset = const Offset(0, 1);
  }
  return CustomTransitionPage<T>(
    transitionDuration: const Duration(milliseconds: 350),
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
            position: Tween<Offset>(begin: offset, end: Offset.zero).animate(
              CurveTween(curve: Curves.easeInOut).animate(animation),
            ),
            child: child),
  );
}

Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder<T>(
        Widget child, FromWhere from) =>
    (BuildContext context, GoRouterState state) {
      return buildPageWithDefaultTransition<T>(
          context: context, state: state, child: child, from: from);
    };
