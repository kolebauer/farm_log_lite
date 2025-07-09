import 'package:flutter/material.dart';
import 'db/database_helper.dart';
import 'models/log.dart';
import 'screens/view_logs_screen.dart';

void main() {
  runApp(const FarmLogLiteApp());
}

class FarmLogLiteApp extends StatelessWidget {
  const FarmLogLiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Log Lite',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const AddLogScreen(),
    );
  }
}

class AddLogScreen extends StatefulWidget {
  const AddLogScreen({super.key});

  @override
  State<AddLogScreen> createState() => _AddLogScreenState();
}

class _AddLogScreenState extends State<AddLogScreen> {
  final _fieldController = TextEditingController();
  final _cropController = TextEditingController();
  final _activityController = TextEditingController();
  final _dateController = TextEditingController();

  final dbHelper = DatabaseHelper();

  void _saveLog() async {
    final log = Log(
      field: _fieldController.text,
      crop: _cropController.text,
      activity: _activityController.text,
      date: _dateController.text,
    );

    await dbHelper.insertLog(log);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Log saved!')),
    );

    _fieldController.clear();
    _cropController.clear();
    _activityController.clear();
    _dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Farm Log')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fieldController,
              decoration: const InputDecoration(labelText: 'Field'),
            ),
            TextField(
              controller: _cropController,
              decoration: const InputDecoration(labelText: 'Crop'),
            ),
            TextField(
              controller: _activityController,
              decoration: const InputDecoration(labelText: 'Activity'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Date'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveLog,
              child: const Text('Save Log'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewLogsScreen(),
                  ),
                );
              },
              child: const Text('View Logs'),
            ),
          ],
        ),
      ),
    );
  }
}
