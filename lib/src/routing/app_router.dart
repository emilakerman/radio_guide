import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/src/features/favorites/presentation/favorites_screen.dart';
import 'package:radio_guide/src/features/channel_list/presentation/list_of_channels_screen.dart';
import 'package:radio_guide/src/features/program_list/presentation/list_of_programs_screen.dart';
import 'package:radio_guide/src/features/start/presentation/start_page.dart';
import 'package:radio_guide/src/routing/app_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.root.name,
      builder: (BuildContext context, GoRouterState state) => const StartPage(),
      routes: [
        GoRoute(
          path: 'channels',
          name: AppRoutes.channels.name,
          builder: (BuildContext context, GoRouterState state) =>
              const ListOfChannelsScreen(),
          routes: [
            GoRoute(
              path: 'programs',
              name: AppRoutes.programs.name,
              builder: (BuildContext context, GoRouterState state) =>
                  ListOfProgramsScreen(channel: state.extra as int),
            ),
            GoRoute(
              path: 'favorites',
              name: AppRoutes.favorites.name,
              builder: (BuildContext context, GoRouterState state) =>
                  const FavoriteScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
