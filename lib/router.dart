import 'package:go_router/go_router.dart';
import 'package:viewer/data/side_menu_data.dart';
import 'package:viewer/pages/main_page.dart'; // Import the side menu data

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        String title = sideMenuData
            .firstWhere((element) => element.route == state.uri.toString(),
                orElse: () => sideMenuData[0])
            .title;
        return MainPage(title: title, child: child);
      },
      routes: sideMenuData.map((item) {
        return GoRoute(
          path: item.route,
          builder: (context, state) => item.page,
        );
      }).toList(),
    ),
  ],
);
