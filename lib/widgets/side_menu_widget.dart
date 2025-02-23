import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:viewer/data/side_menu_data.dart';
import 'package:viewer/model/side_menu_model.dart';
import 'package:viewer/widgets/team_number_input_widget.dart';

class SideMenuWidget extends StatelessWidget {
  const SideMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    print('currentRoute: $currentRoute');

    return Container(
      padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
      color: const Color(0xFF171821),
      child: Column(
        children: [
          TeamNumberInputWidget(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: sideMenuData.length,
              itemBuilder: (context, index) {
                return menuItem(sideMenuData, index, currentRoute, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(List<SideMenuModel> data, int index, String currentRoute,
      BuildContext context) {
    bool isSelected = currentRoute == data[index].route;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          context.go(data[index].route);
        }
        // Navigator.pop(context); // 關閉 Drawer 或側邊欄
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2B2E3B) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Text(
              data[index].title,
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? Colors.white : const Color(0xFF6E7191),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
