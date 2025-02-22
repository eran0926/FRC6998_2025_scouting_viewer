import 'package:flutter/material.dart';
import 'package:viewer/widgets/side_menu_widget.dart';

class MainPage extends StatelessWidget {
  final Widget child;

  const MainPage({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          flex: 2,
          child: SideMenuWidget(),
        ),
        Expanded(
          flex: 8,
          child: child,
        )
      ],
    ));
  }
}
