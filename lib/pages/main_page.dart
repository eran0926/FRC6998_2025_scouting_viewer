import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:viewer/widgets/side_menu_widget.dart';

class MainPage extends StatelessWidget {
  final Widget child;

  const MainPage({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: !ResponsiveBreakpoints.of(context).largerThan(TABLET)
            ? AppBar(
                title: const Text('AppBar with hamburger button'),
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
              )
            : null,
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
