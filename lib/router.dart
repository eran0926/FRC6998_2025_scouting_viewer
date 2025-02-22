import 'package:go_router/go_router.dart';
import 'package:viewer/pages/auto_data_page.dart';
import 'package:viewer/pages/general_data_page.dart';
import 'package:viewer/pages/main_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainPage(child: child),
      routes: [
        // GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(
            path: '/', builder: (context, state) => const GeneralDataPage()),
        GoRoute(
            path: '/auto', builder: (context, state) => const AutoDataPage()),
        // GoRoute(path: '/teleop', builder: (context, state) => const TeleopDataPage()),
        // GoRoute(path: '/subjective', builder: (context, state) => const SubjectiveDataPage()),
      ],
    ),
  ],
);
