import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TeamNumberInputWidget extends StatefulWidget {
  const TeamNumberInputWidget({super.key});

  @override
  State<TeamNumberInputWidget> createState() => _TeamNumberInputWidgetState();
}

class _TeamNumberInputWidgetState extends State<TeamNumberInputWidget> {
  late DateTime _lastUpdated;
  bool isFetching = false;
  List<String> teamList = [];

  void _fetchTeamList() async {
    setState(() {
      isFetching = true;
    });

    // Fetch team data here
    await Future.delayed(const Duration(seconds: 2));
    teamList = ['2345', '2346', '2347', '2348', '2349'];
    setState(() {
      isFetching = false;
      _lastUpdated = DateTime.now();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTeamList();
  }

  @override
  Widget build(BuildContext context) {
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
        onSubmitted: (String value) {
          onFieldSubmitted();
          print('Submitted $value');
        },
        // onEditingComplete: () {
        //   // onFieldSubmitted();
        //   print('Editing complete ${textEditingController.text}');
        // },
        // onTapOutside: (event) {
        //   print('Tapped outside ${textEditingController.text}');
        //   focusNode.unfocus();
        // },
      );
    }, optionsBuilder: (TextEditingValue textEditingValue) async {
      if (textEditingValue.text.isEmpty) {
        return const Iterable<String>.empty();
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
    });
  }
}
