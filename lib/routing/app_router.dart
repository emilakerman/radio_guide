import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/pages/list_of_channels_screen.dart';
import 'package:radio_guide/pages/list_of_programs_screen.dart';
import 'package:radio_guide/pages/start_page.dart';
import 'package:radio_guide/routing/app_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.root.name,
      builder: (BuildContext context, GoRouterState state) => StartPage(),
      routes: [
        GoRoute(
          path: 'channels',
          name: AppRoutes.channels.name,
          builder: (BuildContext context, GoRouterState state) => ListOfChannelsScreen(),
          routes: [
            GoRoute(
              path: 'programs',
              name: AppRoutes.programs.name,
              builder: (BuildContext context, GoRouterState state) =>
                  ListOfProgramsScreen(channel: state.extra as int),
            ),
          ],
        ),
      ],
    ),
  ],
);
