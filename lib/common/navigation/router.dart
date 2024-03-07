import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app.dart';
import 'package:flutter_pokedex/features/captured/captured_page.dart';
import 'package:flutter_pokedex/features/details/details_page.dart';
import 'package:flutter_pokedex/features/main/main_page.dart';
import 'package:flutter_pokedex/features/pokedex/pokedex_page.dart';
import 'package:flutter_pokedex/resources/routes.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> routes = [
  GoRoute(
    path: Routes.initialRoute,
    builder: (BuildContext context, GoRouterState state) {
      return kIsWeb ? const MainPage() : const App();
    },
    routes: <RouteBase>[
      GoRoute(
        path: Routes.connectionError,
        builder: (BuildContext context, GoRouterState state) {
          return const NotConnectionPage();
        },
      ),
      GoRoute(
        path: Routes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const MainPage();
        },
      ),
      GoRoute(
        path: Routes.pokedex,
        builder: (BuildContext context, GoRouterState state) {
          return const PokedexPage();
        },
        routes: <RouteBase>[_details],
      ),
      GoRoute(
        path: Routes.captured,
        builder: (BuildContext context, GoRouterState state) {
          return const CapturedPage();
        },
        routes: <RouteBase>[_details],
      ),
    ],
  ),
];

GoRoute _details = GoRoute(
  path: '${Routes.details}/:name',
  builder: (BuildContext context, GoRouterState state) {
    String name = state.pathParameters['name']!;
    return DetailsPage(name);
  },
);
