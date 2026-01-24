import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:viewer/widgets/side_menu_widget.dart';

class MainPage extends StatelessWidget {
  final String title;
  final Widget child;

  const MainPage({this.title = '', required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: !ResponsiveBreakpoints.of(context).largerThan(TABLET)
        //     ? AppBar(
        appBar: AppBar(
          title: Text(title),
          leading: !ResponsiveBreakpoints.of(context).largerThan(TABLET)
              ? Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                )
              : null,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  context.push('/settings');
                },
              ),
            ),
          ],
        ),
        // : null,
        drawer: !ResponsiveBreakpoints.of(context).largerThan(TABLET)
            ? SizedBox(
                width: 250,
                child: Drawer(
                  child: SideMenuWidget(),
                ),
              )
            : null,
        body: Row(
          children: [
            if (ResponsiveBreakpoints.of(context).largerThan(TABLET))
              // Expanded(
              //   flex: 2,
              //   child: SideMenuWidget(),
              // ),
              SizedBox(
                width: 250,
                child: Drawer(
                  child: SideMenuWidget(),
                ),
              ),
            Expanded(
              // flex: 8,
              child: child,
            )
          ],
        ));
  }
}
