import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:viewer/providers/remote_url_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _remoteUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RemoteUrlProvider remoteUrlProvider =
        Provider.of<RemoteUrlProvider>(context, listen: false);
    _remoteUrlController.text = remoteUrlProvider.remoteUrl;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Remote URL:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _remoteUrlController,
                      decoration: const InputDecoration(
                        labelText: 'Remote URL',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _remoteUrlController.text = 'http://localhost:8000';
                        remoteUrlProvider.setRemoteUrl('http://localhost:8000');
                      },
                      child: Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        remoteUrlProvider
                            .setRemoteUrl(_remoteUrlController.text);
                        context.pop();
                      },
                      child: Text('Save'),
                    ),
                  ],
                )
              ])),
    );
  }
}
