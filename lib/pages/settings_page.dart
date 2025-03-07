import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _controller = TextEditingController();
  final String _defaultUrl = 'http://localhost:8000';

  @override
  void initState() {
    super.initState();
    _loadSavedUrl();
  }

  // Load saved URL from SharedPreferences
  Future<void> _loadSavedUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) return; // Ensure widget is still mounted
    setState(() {
      _controller.text = prefs.getString('remote_url') ?? _defaultUrl;
    });
  }

  // Save URL to SharedPreferences
  Future<void> _saveUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('remote_url', _controller.text);
    if (!mounted) return; // Ensure widget is still mounted
    context.pop(); // Navigate back using go_router
  }

  // Reset URL to default value
  Future<void> _resetUrl() async {
    _controller.text = _defaultUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('remote_url', _defaultUrl);
    if (!mounted) return; // Ensure widget is still mounted
    setState(() {
      _controller.text = _defaultUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Remote URL:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Remote URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      context.pop(), // Navigate back using go_router
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 128, 30, 30)),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _resetUrl, // Reset to default URL
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 61, 91, 114)),
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: _saveUrl,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
