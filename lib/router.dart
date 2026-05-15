import 'package:go_router/go_router.dart';

import 'ui/home/home_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => const HomeView())],
);
