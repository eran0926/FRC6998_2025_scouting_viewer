import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:viewer/services/scouting_api_service.dart';
import 'package:viewer/providers/objective_data_provider.dart';
import 'package:viewer/utils/logger.dart';

class TeamNumberInputWidget extends StatefulWidget {
  const TeamNumberInputWidget({super.key});

  @override
  State<TeamNumberInputWidget> createState() => _TeamNumberInputWidgetState();
}

class _TeamNumberInputWidgetState extends State<TeamNumberInputWidget> {
  late DateTime _lastUpdated;
  bool isFetching = false;
  List<String> teamList = [];
  late ScoutingApiService apiService;

  void _fetchTeamList() async {
    setState(() {
      isFetching = true;
    });

    // Fetch team data here
    // await Future.delayed(const Duration(seconds: 2));
    // teamList = ['2345', '2346', '2347', '2348', '2349'];
    teamList = await apiService.fetchTeams();

    if (mounted) {
      setState(() {
        isFetching = false;
        _lastUpdated = DateTime.now();
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 使用 didChangeDependencies 來初始化 apiService
    apiService = ScoutingApiService(context);
    _fetchTeamList();
  }

  @override
  Widget build(BuildContext context) {
    ObjectiveDataProvider objectiveDataProvider =
        Provider.of<ObjectiveDataProvider>(context, listen: false);
    return Autocomplete<String>(fieldViewBuilder: (BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted) {
      return TextField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: const InputDecoration(
          labelText: 'Team Number',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        // onSubmitted: (String value) {
        //   onFieldSubmitted();
        //   print('Submitted $value');
        // },
        onEditingComplete: () {
          // onFieldSubmitted();
          logger.d('Editing complete ${textEditingController.text}');
          focusNode.unfocus();
          objectiveDataProvider.selectTeam(textEditingController.text);
        },
        onTapOutside: (event) {
          logger.d('Tapped outside ${textEditingController.text}');
          focusNode.unfocus();
          objectiveDataProvider.selectTeam(textEditingController.text);
        },
      );
    }, optionsBuilder: (TextEditingValue textEditingValue) async {
      if (textEditingValue.text.isEmpty) {
        return teamList;
      }
      if (isFetching) {
        return const Iterable<String>.empty();
      }
      if (DateTime.now().difference(_lastUpdated) >
          const Duration(minutes: 5)) {
        _fetchTeamList();
      }
      return teamList.where((String option) =>
          option.startsWith(textEditingValue.text.toLowerCase()));
    }, onSelected: (String selection) {
      logger.d('Selected $selection');
      FocusScope.of(context).unfocus();
      objectiveDataProvider.selectTeam(selection);
    });
  }
}
