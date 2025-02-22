import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:viewer/data/side_menu_data.dart';
import 'package:viewer/model/side_menu_model.dart';
import 'package:viewer/widgets/team_number_input_widget.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: const Color(0xFF171821),
      child: Column(
        children: [
          TeamNumberInputWidget(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: sideMenuData.length,
              itemBuilder: (context, index) => menuItem(sideMenuData, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(List<SideMenuModel> data, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          context.go(data[index].route);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: index == _selectedIndex
              ? const Color(0xFF2B2E3B)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Icon(
            //   data[index].icon,
            //   color: index == _selectedIndex
            //       ? Colors.white
            //       : const Color(0xFF6E7191),
            // ),
            const SizedBox(width: 20),
            Text(
              data[index].title,
              style: TextStyle(
                fontSize: 18,
                color: index == _selectedIndex
                    ? Colors.white
                    : const Color(0xFF6E7191),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
