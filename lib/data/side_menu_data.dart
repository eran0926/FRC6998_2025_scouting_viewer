import 'package:viewer/model/side_menu_model.dart';
import 'package:viewer/pages/auto_data_page.dart';
import 'package:viewer/pages/general_data_page.dart';

final sideMenuData = <SideMenuModel>[
  SideMenuModel(title: 'General Data', route: '/', page: GeneralDataPage()),
  SideMenuModel(title: 'Auto Data', route: '/auto', page: AutoDataPage()),
  // SideMenuModel(title: 'Teleop Data', route: '/teleop', page: TeleopDataPage()),
  // SideMenuModel(title: 'Subjective Data', route: '/subjective', page: SubjectiveDataPage()),
];
